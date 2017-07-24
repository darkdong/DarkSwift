//
//  UINavigationController.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/6/15.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UINavigationController {
    static let keyIsNavigationBarHidden = NSStringFromSelector(#selector(getter: isNavigationBarHidden))
    static let keyIsToolbarHidden = NSStringFromSelector(#selector(getter: isToolbarHidden))

    func save() {
        associatedObject = [
            UINavigationController.keyIsNavigationBarHidden: isNavigationBarHidden,
            UINavigationController.keyIsToolbarHidden: isToolbarHidden,
        ]
    }
    
    func restore() {
        if let dic = associatedObject as? [String: Any] {
            if let value = dic[UINavigationController.keyIsNavigationBarHidden] as? Bool {
                isNavigationBarHidden = value
            }
            if let value = dic[UINavigationController.keyIsToolbarHidden] as? Bool {
                isToolbarHidden = value
            }
        }
    }
}
