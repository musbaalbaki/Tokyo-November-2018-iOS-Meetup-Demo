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

