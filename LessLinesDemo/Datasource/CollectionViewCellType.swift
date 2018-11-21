//
//  CollectionViewCellType.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/21/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

enum CollectionViewCellType {
    case photoItem(Photo)
}

extension CollectionViewCellType {
    var collectionViewCellDescriptor: CollectionViewCellDescriptor {
        switch self {
        case .photoItem(let photo):
            return CollectionViewCellDescriptor(reuseIdentifier: PhotoItemCollectionViewCell.className, configure:photo.configure)
        }
    }
}
