//
//  UICollectionView+Helpers.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

extension UICollectionView {
    func sizeForItem(numberOfItemsPerRow: Int, aspectRatio: CGFloat, collectionViewFlowLayout: UICollectionViewFlowLayout) -> CGSize {
        let floatNumberOfItems = CGFloat(numberOfItemsPerRow)
        let totalScreenWidth = UIScreen.main.bounds.width
        let spacingWidth = (floatNumberOfItems - 1.0) * collectionViewFlowLayout.minimumInteritemSpacing
        let collectionViewInsetsWidth = self.contentInset.left + self.contentInset.right
        let flowLayoutSectionInsets = collectionViewFlowLayout.sectionInset.left + collectionViewFlowLayout.sectionInset.right
        let itemWidth = (totalScreenWidth - collectionViewInsetsWidth - flowLayoutSectionInsets - spacingWidth) / floatNumberOfItems
        let itemHeight = itemWidth / aspectRatio
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
