//
//  TargetAction.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import Foundation

final class TargetAction: NSObject {
    let callback: () -> ()
    init(callback: @escaping () -> ()) {
        self.callback = callback
    }
    
    @objc func action(sender: Any) {
        self.callback()
    }
}
