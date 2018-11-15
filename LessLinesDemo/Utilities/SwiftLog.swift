//
//  SwiftLog.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import Foundation

/// Logs the message to the console with extra information, e.g. file name, method name and line number
///
/// To make it work you must set the "DEBUG" symbol, set it in the "Swift Compiler - Custom Flags" section, "Other Swift Flags" line.
/// You add the DEBUG symbol with the -D DEBUG entry.

public func debugLog(functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    #if DEBUG
    let className = (fileName as NSString).lastPathComponent
    print("<\(className)> \(functionName) [#\(lineNumber)]")
    #endif
}
