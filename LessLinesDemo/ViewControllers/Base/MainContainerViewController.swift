//
//  MainContainerViewController.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

class MainContainerViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var handleRootViewController: () -> () = {}
    
    var viewController: UIViewController? {
        willSet(newViewController) {
            if let unwrappedViewController = viewController {
                remove(contentViewController: unwrappedViewController)
            }
            if let unwrappedNewViewController = newViewController {
                add(contentViewController: unwrappedNewViewController, toContainerView: containerView)
            }
        }
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleRootViewController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let unwrappedViewController = viewController else {
            return .lightContent
        }
        return unwrappedViewController.preferredStatusBarStyle
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        guard let unwrappedViewController = viewController else {
            return .fade
        }
        return unwrappedViewController.preferredStatusBarUpdateAnimation
    }
    
    override var prefersStatusBarHidden: Bool {
        guard let unwrappedViewController = viewController else {
            return false
        }
        return unwrappedViewController.prefersStatusBarHidden
    }
}

extension MainContainerViewController {
    open override var childForStatusBarStyle: UIViewController? {
        return viewController
    }
}
