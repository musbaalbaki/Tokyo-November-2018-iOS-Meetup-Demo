//
//  GenericHorizontalCollectionViewController.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

struct HorizontalCollectionViewLayoutFactory {
    let flowLayout: UICollectionViewFlowLayout
    let width: CGFloat
    let height: CGFloat
}

final class GenericHorizontalCollectionViewController<Item>: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var items: [Item] = []
    let cellDescriptor: (Item) -> CollectionViewCellDescriptor
    var reuseIdentifiers: Set<String> = []
    var didSelect: (Item) -> () = { _ in }
    let collectionViewLayoutFactory: HorizontalCollectionViewLayoutFactory
    var backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    var titles: [String]?
    var titleFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    
    // MARK: - Computed Properties
    
    fileprivate var verticalLineItems: CGFloat {
        get {
            return 1
        }
    }
    
    public var totalHeight: CGFloat {
        get {
            return collectionView!.contentInset.top + collectionViewLayoutFactory.flowLayout.sectionInset.top + (verticalLineItems * itemHeight) + ((verticalLineItems - 1) *  collectionViewLayoutFactory.flowLayout.minimumLineSpacing) + collectionViewLayoutFactory.flowLayout.sectionInset.bottom + collectionView!.contentInset.bottom
        }
    }
    
    fileprivate var itemWidth: CGFloat {
        get {
            return collectionViewLayoutFactory.width
        }
    }
    
    fileprivate var itemHeight: CGFloat {
        get {
            return collectionViewLayoutFactory.height
        }
    }
    
    // MARK: - Override Init
    
    init(items: [Item], cellDescriptor: @escaping (Item) -> CollectionViewCellDescriptor, collectionViewLayoutFactory: HorizontalCollectionViewLayoutFactory) {
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
        if self.titles == nil {
            return CGSize(width: itemWidth, height: itemHeight)
        } else {
            let title = self.titles![indexPath.row]
            let width = UILabel.textWidth(font:titleFont, text: title)
            return CGSize(width: width + 10, height: itemHeight)
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }
}
