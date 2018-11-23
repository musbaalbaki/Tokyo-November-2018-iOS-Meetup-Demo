//
//  DatasourceFactory.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

struct DatasourceFactory {
    static func datasourceForPhotosList(_ photos: [Photo]) -> [TableViewCellType] {
        var items: [TableViewCellType] = []
        let collagePhotos: [Photo] = Array(photos.prefix(20))
        let totalPhotos: [Photo] = Array(photos.prefix(45))
        items.append(.spacing)
        items.append(.photoCollage(collagePhotos))
        items.append(.spacing)
        
        for photo in totalPhotos {
            items.append(.photoItem(photo))
        }
        items.append(.spacing)
        return items
    }
    
    static func dataSourceForPhotoItemsCollage(_ photos: [Photo]) -> [CollectionViewCellType] {
        var items: [CollectionViewCellType] = []
        
        for photo in photos {
            items.append(.photoItem(photo))
        }
        return items
    }
}
