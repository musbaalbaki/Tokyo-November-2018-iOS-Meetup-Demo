//
//  GenericCollectionViewController.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

struct CollectionViewCellDescriptor {
    let cellClass: UICollectionViewCell.Type
    let reuseIdentifier: String
    let configure: (UICollectionViewCell) -> ()
    
    init<Cell: UICollectionViewCell>(reuseIdentifier: String, configure: @escaping (Cell) -> ()) {
        self.cellClass = Cell.self
        self.reuseIdentifier = reuseIdentifier
        self.configure = { cell in
            configure(cell as! Cell)
        }
    }
}

struct CollectionViewLayoutFactory {
    let flowLayout: UICollectionViewFlowLayout
    let phonePortraitItemsCount: Int
    let phoneLandscapeItemsCount: Int
    let padPortraitItemsCount: Int
    let padLandscapeItemsCount: Int
    let itemAspectRatio: CGFloat
}

final class GenericCollectionViewController<Item>: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var items: [Item] = []
    let cellDescriptor: (Item) -> CollectionViewCellDescriptor
    var reuseIdentifiers: Set<String> = []
    var didSelect: (Item) -> () = { _ in }
    let collectionViewLayoutFactory: CollectionViewLayoutFactory
    var backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    // MARK: - Computed Properties
    
    fileprivate var horizontalLineItems: CGFloat {
        get {
            switch DeviceOrientation.current {
            case .PhonePortrait:
                return CGFloat(self.collectionViewLayoutFactory.phonePortraitItemsCount)
            case .PhoneLandscape:
                return CGFloat(self.collectionViewLayoutFactory.phoneLandscapeItemsCount)
            case .PadPortrait:
                return CGFloat(self.collectionViewLayoutFactory.padPortraitItemsCount)
            case .PadLandscape:
                return CGFloat(self.collectionViewLayoutFactory.padLandscapeItemsCount)
            }
        }
    }
    
    fileprivate var verticalLineItems: CGFloat {
        get {
            return (CGFloat(items.count) / horizontalLineItems).rounded(.up)
        }
    }
    
    public var totalHeight: CGFloat {
        get {
            return collectionView!.contentInset.top + collectionViewLayoutFactory.flowLayout.sectionInset.top + (verticalLineItems * itemHeight) + ((verticalLineItems - 1) *  collectionViewLayoutFactory.flowLayout.minimumLineSpacing) + collectionViewLayoutFactory.flowLayout.sectionInset.bottom + collectionView!.contentInset.bottom
        }
    }
    
    fileprivate var itemWidth: CGFloat {
        get {
            let screenWidth = UIScreen.main.bounds.width
            return (screenWidth - collectionView!.contentInset.left - collectionView!.contentInset.right - collectionViewLayoutFactory.flowLayout.sectionInset.left - collectionViewLayoutFactory.flowLayout.sectionInset.right - ((horizontalLineItems - 1) * collectionViewLayoutFactory.flowLayout.minimumInteritemSpacing)) / horizontalLineItems
        }
    }
    
    fileprivate var itemHeight: CGFloat {
        get {
            return itemWidth / collectionViewLayoutFactory.itemAspectRatio
        }
    }
    
    // MARK: - Override Init
    
    init(items: [Item], cellDescriptor: @escaping (Item) -> CollectionViewCellDescriptor, collectionViewLayoutFactory: CollectionViewLayoutFactory) {
        
        self.cellDescriptor = cellDescriptor
        self.items = items
        self.collectionViewLayoutFactory = collectionViewLayoutFactory
        super.init(collectionViewLayout: collectionViewLayoutFactory.flowLayout)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.isScrollEnabled = false
        self.collectionView?.backgroundColor = backgroundColor
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let descriptor = cellDescriptor(item)
        if !reuseIdentifiers.contains(descriptor.reuseIdentifier) {
            let nib = UINib(nibName: descriptor.reuseIdentifier, bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: descriptor.reuseIdentifier)
            reuseIdentifiers.insert(descriptor.reuseIdentifier)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptor.reuseIdentifier, for: indexPath)
        descriptor.configure(cell)
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }
}
