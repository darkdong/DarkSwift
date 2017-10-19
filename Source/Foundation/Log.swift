//
//  Logger.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/31.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

// Since Xcode 8 and swift 3, print no longer outputs in Device Console but does in debugger console.
public class Log {
    public var isEnabled: Bool

    public static let shared = Log()
    
    public init(isEnabled: Bool = true) {
        self.isEnabled = isEnabled
    }
    
    public func log(_ format: String, _ args: CVarArg = []) {
        if isEnabled {
            NSLog(format, args)
        }
    }
    
    public func print(file: String = #file, funcname: String = #function, _ items: Any...) {
        if isEnabled {
            Swift.print((file as NSString).lastPathComponent, funcname, items)
        }
    }
}
