//
//  TableViewCellType.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

enum TableViewCellType {
    case photoItem(Photo)
    case photoCollage([Photo])
    case spacing
}

extension TableViewCellType {
    var tableViewCellDescriptor: TableViewCellDescriptor {
        switch self {
        case .photoItem(let photo):
            return TableViewCellDescriptor(reuseIdentifier: ItemTableViewCell.className, configure: photo.configure)
        case .photoCollage(let photosArray):
            return TableViewCellDescriptor(reuseIdentifier: PhotoItemsCollageTableViewCell.className, configure: photosArray.configure)
        case .spacing:
            return TableViewCellDescriptor(reuseIdentifier: SpacingTableViewCell.className, configure: { _ in })
        }
    }
}
