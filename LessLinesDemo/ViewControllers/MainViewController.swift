//
//  ViewController.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/14/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainViewController: UIViewController {
    
    var showDetail: (Photo) -> () = { _ in }
    
    @IBOutlet weak var containerView: UIView!
    
    private lazy var tableViewController: GenericTableViewController = { () -> GenericTableViewController<TableViewCellType> in
        return GenericTableViewController(items: [], cellDescriptor: { $0.tableViewCellDescriptor })
    }()
    
    private var datasource: [TableViewCellType] = [] {
        didSet {
            tableViewController.items = datasource
            tableViewController.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        load(Endpoints.photosList.endPoint)
    }
    
    private func setupViewController() {
        self.title = "Less Lines"
        add(contentViewController: tableViewController, toContainerView: containerView)
        tableViewController.didSelect = { [unowned self] tableViewCellType in
            switch tableViewCellType {
            case .photoItem(let photo):
                self.showDetail(photo)
            default: break
            }
        }
    }
}

extension MainViewController: LoadingViewController {
    func configure(value: JSON) {
        let photos = value.arrayValue.compactMap { Photo(json: $0) }
        datasource = DatasourceFactory.datasourceForPhotosList(photos)
    }
}

