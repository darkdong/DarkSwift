//
//  Foundation.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/3.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

public protocol Cloneable {
    func clone<T>() -> T
}

public extension Cloneable {
    func clone<T>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
}
