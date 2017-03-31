//
//  Logger.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/31.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public class Logger {
    public var isEnabled = true

    public static let shared = Logger()
    
    public static func log(_ format: String, _ args: CVarArg = []) {
        shared.log(format, args)
    }
    
    public static func print<T>(_ object: T) {
        shared.print(object)
    }
    
    public func log(_ format: String, _ args: CVarArg = []) {
        if isEnabled {
            NSLog(format, args)
        }
    }
    
    public func print<T>(_ object: T) {
        if isEnabled {
            Swift.print(object)
        }
    }
}
