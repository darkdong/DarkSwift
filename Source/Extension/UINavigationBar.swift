//
//  UINavigationBar.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/7/24.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public protocol SaveRestore {
    func save()
    func restore()
}

extension UIToolbar: SaveRestore {
    public func save() {
    }
    
    public func restore() {
    }
}

public extension UINavigationBar {
    static let keyIsTranslucent = NSStringFromSelector(#selector(getter: isTranslucent))
    static let keyBackgroundImage = NSStringFromSelector(#selector(backgroundImage(for:)))
    static let keyShadowImage = NSStringFromSelector(#selector(getter: shadowImage))
    static let keyBackIndicatorImage = NSStringFromSelector(#selector(getter: backIndicatorImage))
    static let keyBarStyle = NSStringFromSelector(#selector(getter: barStyle))
    static let keyBarTintColor = NSStringFromSelector(#selector(getter: barTintColor))
    static let keyTintColor = NSStringFromSelector(#selector(getter: tintColor))
    static let keyTitleTextAttributes = NSStringFromSelector(#selector(getter: titleTextAttributes))

    func save() {
        associatedObject = [
            UINavigationBar.keyIsTranslucent: isTranslucent,
            UINavigationBar.keyBackgroundImage: backgroundImage(for: .default) as Any,
            UINavigationBar.keyShadowImage: shadowImage as Any,
            UINavigationBar.keyBackIndicatorImage: backIndicatorImage as Any,
            UINavigationBar.keyBarStyle: barStyle,
            UINavigationBar.keyBarTintColor: barTintColor as Any,
            UINavigationBar.keyTintColor: tintColor as Any,
            UINavigationBar.keyTitleTextAttributes: titleTextAttributes as Any,
        ]
    }
    
    func restore() {
        if let dic = associatedObject as? [String: Any] {
            if let value = dic[UINavigationBar.keyIsTranslucent] as? Bool {
                isTranslucent = value
            }
            if let value = dic[UINavigationBar.keyBackgroundImage] as? UIImage {
                setBackgroundImage(value, for: .default)
            }
            if let value = dic[UINavigationBar.keyShadowImage] as? UIImage {
                shadowImage = value
            }
            if let value = dic[UINavigationBar.keyBackIndicatorImage] as? UIImage {
                backIndicatorImage = value
            }
            if let value = dic[UINavigationBar.keyBarStyle] as? UIBarStyle {
                barStyle = value
            }
            if let value = dic[UINavigationBar.keyBarTintColor] as? UIColor {
                barTintColor = value
            }
            if let value = dic[UINavigationBar.keyTintColor] as? UIColor {
                tintColor = value
            }
            if let value = dic[UINavigationBar.keyTitleTextAttributes] as? [String: Any] {
                titleTextAttributes = value
            }
        }
    }
}
