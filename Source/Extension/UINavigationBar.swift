//
//  UINavigationBar.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/8/30.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UINavigationBar {
    private static let keyHidesShadow = "hidesShadow"
    var isHairlineHidden: Bool {
        get {
            return value(forKey: UINavigationBar.keyHidesShadow) as! Bool
        }
        set {
            setValue(newValue, forKey: UINavigationBar.keyHidesShadow)
        }
    }
}
