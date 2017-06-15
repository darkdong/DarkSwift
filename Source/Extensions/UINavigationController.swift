//
//  UINavigationController.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/6/15.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UINavigationController {
    func save() {
        associatedObject = [
            NSStringFromSelector(#selector(getter: isNavigationBarHidden)): isNavigationBarHidden,
            NSStringFromSelector(#selector(getter: isToolbarHidden)): isToolbarHidden,
        ]
    }
    
    func restore() {
        if let dic = associatedObject as? [String: Any] {
            if let value = dic[NSStringFromSelector(#selector(getter: isNavigationBarHidden))] as? Bool {
                isNavigationBarHidden = value
            }
            if let value = dic[NSStringFromSelector(#selector(getter: isToolbarHidden))] as? Bool {
                isToolbarHidden = value
            }
        }
    }
}
