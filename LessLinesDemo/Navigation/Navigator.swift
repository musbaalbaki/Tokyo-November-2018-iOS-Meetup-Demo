//
//  Navigator.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

final class Navigator {
    var mainNavigationController: UINavigationController!
    var mainViewController: MainViewController!

    init(_ window: UIWindow) {
        mainNavigationController = window.rootViewController as? UINavigationController
        mainViewController = mainNavigationController.viewControllers.first as? MainViewController
        mainViewController.showDetail = showDetail
    }
    
    func showDetail(photo: Photo) {
        // TODO: - Implement me
    }
}
