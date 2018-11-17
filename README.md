# Tokyo-November-2018-iOS-Meetup-Demo
How to build iOS apps using less lines of code?

In this demo we will build an app that calls an API and populate a list of Photo items in a generic UITableViewController that is construcuted using an array of enums.

### API call, JSON response and model generation

Let's request this GET API and check the JSON response first:

* https://jsonplaceholder.typicode.com/photos

This will return a JSON of this format:

```json
  [{
    "albumId": 1,
    "id": 5,
    "title": "natus nisi omnis corporis facere molestiae rerum in",
    "url": "https://via.placeholder.com/600/f66b97",
    "thumbnailUrl": "https://via.placeholder.com/150/f66b97"
  },
  {
    "albumId": 1,
    "id": 6,
    "title": "accusamus ea aliquid et amet sequi nemo",
    "url": "https://via.placeholder.com/600/56a8c2",
    "thumbnailUrl": "https://via.placeholder.com/150/56a8c2"
  }]
  ```
  
  We will use [SwiftyJSONAccelerator](https://github.com/insanoid/SwiftyJSONAccelerator) to auto generate our model object so that we don't have to write any model or service reponse object manullay. 
  
  This will generate ```Photo.swift``` for us. 
  
  Now to actually call that API in the app we need to do three steps
  
  1. Add the base URL for all the app's endpoints in ```URLs.plist``` typically this step should only be made one time for all the requests.
  2. Add a new case in ```Endpoints.swift``` enum. When adding a new case make sure to add the path, type and any possible paramaters in the Endpoints extension.
  
  ```swift
enum Endpoints {
    case photosList
}

extension Endpoints {
    var endPoint: Endpoint<JSON> {
        switch self {
        case .photosList:
            return Endpoint(url: URLFactory.getURL(path: "photos")!) { JSON($0) }
        }
    }
}
```

3. Conform your view controller to the ```LoadingViewController``` protocol and call when needed
```swift 
load(Endpoints.photosList.endPoint)
```

4. Implement the LoadingViewController protocol func configure that will pass in the SwiftyJSON value. Since the top level object of the JSON response is actually an array then we can map over the reponse and create an array of our own model ```[Photo]```
```swift
let photos = value.arrayValue.compactMap { Photo(json: $0) }
```
Now at this point we have an array of photos, that is our own custom model. We will use this array of photos later on to populate our table view. 


### Design our UI components

* This is very simple, all we need to do is create our own ```ItemTableViewCell.xib``` and design it the way we want. Note that our generic table view controller uses automatic dimensions for the height so if you set the auto layout properly here, the cell will dynamically size itself. 
* Connect all the neccessarly outlets that should be dynammic

### UI - Data binding 

To bind UI with data all we need to do is to provide an extension on our model object and implmennt a configure function that pass in our custom ```ItemTableViewCell``` and configure it

```swift
extension Photo {
    func configure(_ cell: ItemTableViewCell) {
        cell.itemTitleLabel.text = self.title
        cell.photoImageView.fetchImage(self.thumbnailUrl)
    }
}
```

### Add an enum case for our component

Add the new component we created into our public list of enums so that it's reuseable across all the app. Note that for each case there is an associated object which is basically whatever data needed to construct such a component. This could be dynamic or static data

```swift
enum TableViewCellType {
    case photoItem(Photo)
}

extension TableViewCellType {
    var tableViewCellDescriptor: TableViewCellDescriptor {
        switch self {
        case .photoItem(let photo):
            return TableViewCellDescriptor(reuseIdentifier: ItemTableViewCell.className, configure: photo.configure)
        }
    }
}
```

### View Controller 

To use any of the above concept in any view controller all we have to do is to create a new view controller and add a container view that we can add into the storyboard or programatically. If we want our list to actually fill in the whole view then we can pin that container view so the edges. 

Next add our generic table view controller like this:

```swift
private lazy var tableViewController: GenericTableViewController = { () -> GenericTableViewController<TableViewCellType> in
    return GenericTableViewController(items: [], cellDescriptor: { $0.tableViewCellDescriptor })
}()

private var datasource: [TableViewCellType] = [] {
    didSet {
        tableViewController.items = datasource
        tableViewController.tableView.reloadData()
    }
}
```
Add our custom generic table view controller into that view like this using our useful extension below. 

```swift
add(contentViewController: tableViewController, toContainerView: containerView)
```

Now whenever we set the ```datasource``` it will automatically update our list. Now to set our datasource all we need is some data that knows how to constuct our list. In our case an array of ```Photo``` is all we need to populate our list. 

### Populate our list using an array of enums

This is happening in the ```DatasourceFactory``` and here where the magic is happening. We can just populating an array of enums (consiting of our re-usuable compomenents) and returning it

```swift
struct DatasourceFactory {
    static func datasourceForPhotosList(_ photos: [Photo]) -> [TableViewCellType] {
        var items: [TableViewCellType] = []
        for photo in photos {
            items.append(.photoItem(photo))
        }
        return items
    }
}
```

Now in the view controller we ask for this array once we receive the API response or whenever we need to update our list. 

```swift
datasource = DatasourceFactory.datasourceForPhotosList(photos)
```

---

You can download a copy of the presentation [here](https://drive.google.com/open?id=1gHhTbrt8CKejkc_ilQFtrdaJRI0bY_OW) created using the Keynote Mac app

---

Note that some of the concepts here were inspired from my previous experience workign with several tech companies and [several talks from objc.io](https://www.objc.io)

