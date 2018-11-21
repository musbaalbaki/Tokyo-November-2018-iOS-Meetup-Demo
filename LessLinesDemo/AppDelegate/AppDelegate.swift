//
//  AppDelegate.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/14/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigator: Navigator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupApp()
        if let window = window {
            navigator = Navigator(window)
        }
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return RotationSupportManager.orientationsToSupport
    }
}

