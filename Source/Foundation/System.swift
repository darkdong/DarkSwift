//
//  Foundation.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/3.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

//public protocol Cloneable {
//    func clone<T>() -> T?
//}
//
//public extension Cloneable {
//    func clone<T>() -> T? {
//        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as? T
//    }
//}

public class System: NSObject {
    public static var currentQueueName: String? {
        let name = __dispatch_queue_get_label(nil)
        return String(cString: name, encoding: .utf8)
    }
}
