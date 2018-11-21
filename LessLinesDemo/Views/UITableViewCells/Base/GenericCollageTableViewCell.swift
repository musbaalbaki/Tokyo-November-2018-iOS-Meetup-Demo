//
//  GenericCollageTableViewCell.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/21/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

class GenericCollageTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet weak var collectionViewContainerView: UIView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    var collectionViewController: GenericCollectionViewController<CollectionViewCellType>?
    func configure(collectionViewLayoutFactory: CollectionViewLayoutFactory, items: [CollectionViewCellType], backgroundColor: UIColor = #colorLiteral(red: 0.9294117647, green: 0.9411764706, blue: 0.9490196078, alpha: 1)) {
        if self.collectionViewController == nil {
            self.collectionViewController = GenericCollectionViewController(items: items, cellDescriptor: {$0.collectionViewCellDescriptor}, collectionViewLayoutFactory: collectionViewLayoutFactory)
            self.collectionViewController?.backgroundColor = backgroundColor
            self.collectionViewContainerView.addSubview(self.collectionViewController!.view)
            self.collectionViewController?.collectionView?.constrainEdges(toMarginOf: self.collectionViewContainerView)
        } else {
            self.collectionViewController?.items = items
        }
        self.collectionViewHeightConstraint.constant = self.collectionViewController!.totalHeight
        self.collectionViewController!.collectionView?.reloadData()
        self.collectionViewController!.collectionView?.layoutIfNeeded()
    }
}
