//
//  Photo+ViewModel.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

extension Photo {
    func configure(_ cell: ItemTableViewCell) {
        cell.itemTitleLabel.text = self.title
        cell.photoImageView.fetchImage(self.thumbnailUrl)
    }
    
    func configure(_ cell: PhotoItemCollectionViewCell) {
        cell.photoTitleLabel.text = self.title
        cell.photoImageView.fetchImage(self.thumbnailUrl)
    }
}

extension Array where Element == Photo {
    func configure(_ cell: PhotoItemsCollageTableViewCell) {
        let items = DatasourceFactory.dataSourceForPhotoItemsCollage(self)
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

