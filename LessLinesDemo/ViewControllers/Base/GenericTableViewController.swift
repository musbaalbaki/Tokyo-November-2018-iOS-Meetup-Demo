//
//  GenericTableViewController.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

struct TableViewCellDescriptor {
    let cellClass: UITableViewCell.Type
    let reuseIdentifier: String
    let configure: (UITableViewCell) -> ()
    
    init<Cell: UITableViewCell>(reuseIdentifier: String, configure: @escaping (Cell) -> ()) {
        self.cellClass = Cell.self
        self.reuseIdentifier = reuseIdentifier
        self.configure = { cell in
            configure(cell as! Cell)
        }
    }
}

final class GenericTableViewController<Item>: UITableViewController {
    
    // MARK: - Properties
    
    var items: [Item] = []
    let cellDescriptor: (Item) -> TableViewCellDescriptor
    var reuseIdentifiers: Set<String> = []
    var visibleIndexPaths: [IndexPath]?
    var didSelect: (Item) -> () = { _ in }
    var cellHeights: [IndexPath : CGFloat] = [:]
    
    // MARK: - Initializer
    
    init(items: [Item], cellDescriptor: @escaping (Item) -> TableViewCellDescriptor) {
        self.cellDescriptor = cellDescriptor
        super.init(style: .plain)
        self.items = items
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let descriptor = cellDescriptor(item)
        
        if !reuseIdentifiers.contains(descriptor.reuseIdentifier) {
            let nib = UINib(nibName: descriptor.reuseIdentifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: descriptor.reuseIdentifier)
            reuseIdentifiers.insert(descriptor.reuseIdentifier)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: descriptor.reuseIdentifier, for: indexPath)
        descriptor.configure(cell)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = cellHeights[indexPath] else { return UITableView.automaticDimension }
        return height
    }
}

