//
//  LoadingViewController.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol LoadingViewController {
    associatedtype EndPointResultType
    func configure(value: EndPointResultType)
    func didLoad(fromCache: Bool)
}

extension LoadingViewController where Self: UIViewController {
    func load(_ endpoint: Endpoint<EndPointResultType>, showActivityIndicator: Bool = true) {
        if showActivityIndicator == true {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        API.request(endpoint) { result, isFromCache  in
            
            if isFromCache == false && showActivityIndicator == true {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            guard let value = result.value else { return }
            
            self.configure(value: value)
            self.didLoad(fromCache: isFromCache)
        }
    }
    
    func didLoad(fromCache: Bool) {
        // Default implmentation to use didLoad as an optional protocol in Swift
    }
}
