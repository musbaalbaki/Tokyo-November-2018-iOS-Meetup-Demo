//
//  UIImageView+Helpers.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageViewAsTemplate(withTintColor: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = withTintColor
    }
    
    func fetchImage(_ stringURL: String?, completionHandler: (() -> ())? = nil) {
        guard let stringURL = stringURL else {
            self.image = nil
            return
        }
        guard let url = URL(string: stringURL) else {
            self.image = nil
            return
        }
        self.kf.indicatorType = .activity
        
        if let completionHandler = completionHandler {
            self.kf.setImage(with: url, placeholder: nil) {
                (_, _, _, _) in
                completionHandler()
            }
            
        } else {
            self.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(1.0))])
        }
    }
}
