//
//  NSObject.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/5/26.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

private var associatedObjectKey = 0

public extension NSObject {
    func trace(timestamp: Bool = false, funcname: String = #function, _ items: Any...) {
        if timestamp {
            print(Date(), type(of: self), funcname, items)
        } else {
            print(type(of: self), funcname, items)
        }
    }

    func clone() -> AnyObject {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as AnyObject
    }
    
    var associatedObject: Any? {
        get {
            return objc_getAssociatedObject(self, &associatedObjectKey)
        }
        set {
            objc_setAssociatedObject(self, &associatedObjectKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}
