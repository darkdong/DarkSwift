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
            isNavigationBarHidden,
            isToolbarHidden
        ]
    }
    
    func restore() {
        if let oldValues = associatedObject as? [Any] {
            isNavigationBarHidden = oldValues[0] as! Bool
            isToolbarHidden = oldValues[1] as! Bool
        }
    }
}
