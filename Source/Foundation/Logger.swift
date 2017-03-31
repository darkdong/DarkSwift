//
//  Logger.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/31.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public class Logger {
    var isEnabled = true

    static let shared = Logger()
    
    static func log(_ format: String, _ args: CVarArg = []) {
        shared.log(format, args)
    }
    
    static func print<T>(_ object: T) {
        shared.print(object)
    }
    
    func log(_ format: String, _ args: CVarArg = []) {
        if isEnabled {
            NSLog(format, args)
        }
    }
    
    func print<T>(_ object: T) {
        if isEnabled {
            Swift.print(object)
        }
    }
}
