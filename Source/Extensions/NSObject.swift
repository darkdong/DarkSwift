//
//  NSObject.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/5/26.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public extension NSObject {
    func clone() -> AnyObject {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as AnyObject
    }
}
