//
//  UIAppearance.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import UIKit
import SVProgressHUD

final class UIAppearance {
    static func customize() {
        // SVProgressHUD Appearance
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setForegroundColor(.black)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.setHapticsEnabled(true)
    }
}
