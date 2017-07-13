//
//  Logger.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/31.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

// Since Xcode 8 and swift 3, print no longer outputs in Device Console but does in debugger console.
public class Logger {
    public var isEnabled = true

    public static let shared = Logger()
    
    public static func log(_ format: String, _ args: CVarArg = []) {
        shared.log(format, args)
    }
    
    public func log(_ format: String, _ args: CVarArg = []) {
        if isEnabled {
            NSLog(format, args)
        }
    }
}
