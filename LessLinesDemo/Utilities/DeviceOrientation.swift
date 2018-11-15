//
//  DeviceOrientation.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit

enum DeviceOrientation: String {
    case PhonePortrait = "PhonePortrait"
    case PhoneLandscape = "PhoneLandscape"
    case PadPortrait = "PadPortrait"
    case PadLandscape = "PadLandscape"
    
    static var current: DeviceOrientation {
        get {
            let size = UIScreen.main.coordinateSpace.bounds.size
            if UIDevice.current.userInterfaceIdiom == .phone {
                if size.width < size.height {
                    return .PhonePortrait
                } else {
                    return .PhoneLandscape
                }
            } else {
                if size.width < size.height {
                    return .PadPortrait
                } else {
                    return .PadLandscape
                }
            }
        }
    }
}
