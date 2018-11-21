//
//  PhotoCollage+ViewModel.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/21/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

extension PhotoCollage {
    func configure(_ cell: PhotoItemsCollageTableViewCell) {
        let items = DatasourceFactory.dataSourceForPhotoItemsCollage(self.photos)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 7
        flowLayout.minimumInteritemSpacing = 7
        flowLayout.scrollDirection = .vertical
        let aspectRatio = CGFloat(375.0/524.0)
        let collectionViewLayoutFactory = CollectionViewLayoutFactory(flowLayout: flowLayout,
                                                                      phonePortraitItemsCount: 2,
                                                                      phoneLandscapeItemsCount: 4,
                                                                      padPortraitItemsCount: 7,
                                                                      padLandscapeItemsCount: 12,
                                                                      itemAspectRatio: aspectRatio)
        cell.configure(collectionViewLayoutFactory: collectionViewLayoutFactory, items: items)
    }
}
