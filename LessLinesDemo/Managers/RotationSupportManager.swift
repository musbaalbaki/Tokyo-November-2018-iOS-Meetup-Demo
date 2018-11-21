//
//  RotationSupportManager.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/21/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

final class RotationSupportManager {
    static var orientationsToSupport: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if DeviceOrientation.detectiPhoneX == true {
                return [.portrait]
            } else {
                return [.allButUpsideDown]
            }
        } else {
            return [.all]
        }
    }
}
