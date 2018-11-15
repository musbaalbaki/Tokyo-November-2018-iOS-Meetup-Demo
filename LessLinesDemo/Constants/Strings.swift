//
//  Strings.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import Foundation

extension String {
        
    // MARK: - Alert options
    
    static var yes: String {
        return NSLocalizedString("Yes", comment: "title")
    }
    
    static var okay: String {
        return NSLocalizedString("Okay", comment: "title")
    }
    
    static var no: String {
        return NSLocalizedString("No", comment: "title")
    }
    
    static var cancel: String {
        return NSLocalizedString("Cancel", comment: "title")
    }
}
