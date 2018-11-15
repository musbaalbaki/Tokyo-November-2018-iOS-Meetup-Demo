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
        for photo in photos {
            items.append(.photoItem(photo))
        }
        return items
    }
}
