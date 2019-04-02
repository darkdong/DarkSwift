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

extension UINavigationController: SaveRestore {
    static let keyIsNavigationBarHidden = NSStringFromSelector(#selector(getter: isNavigationBarHidden))
    static let keyIsToolbarHidden = NSStringFromSelector(#selector(getter: isToolbarHidden))
    
    public func save() {
        associatedObject = [
            UINavigationController.keyIsNavigationBarHidden: isNavigationBarHidden,
            UINavigationController.keyIsToolbarHidden: isToolbarHidden,
        ]
    }
    
    public func restore() {
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

extension UINavigationBar: SaveRestore {
    static let keyIsTranslucent = NSStringFromSelector(#selector(getter: isTranslucent))
    static let keyBarStyle = NSStringFromSelector(#selector(getter: barStyle))
    static let keyBarTintColor = NSStringFromSelector(#selector(getter: barTintColor))
    static let keyTintColor = NSStringFromSelector(#selector(getter: tintColor))
    static let keyTitleTextAttributes = NSStringFromSelector(#selector(getter: titleTextAttributes))
    static let keyShadowImage = NSStringFromSelector(#selector(getter: shadowImage))
    static let keyBackIndicatorImage = NSStringFromSelector(#selector(getter: backIndicatorImage))
    static let keyBackgroundImage = NSStringFromSelector(#selector(backgroundImage(for:)))

    public func save() {
        associatedObject = [
            UINavigationBar.keyIsTranslucent: isTranslucent,
            UINavigationBar.keyBarStyle: barStyle,
            UINavigationBar.keyBarTintColor: barTintColor as Any,
            UINavigationBar.keyTintColor: tintColor as Any,
            UINavigationBar.keyTitleTextAttributes: titleTextAttributes as Any,
            UINavigationBar.keyShadowImage: shadowImage as Any,
            UINavigationBar.keyBackIndicatorImage: backIndicatorImage as Any,
            UINavigationBar.keyBackgroundImage: backgroundImage(for: .default) as Any,
        ]
    }
    
    public func restore() {
        if let dic = associatedObject as? [String: Any] {
            if let value = dic[UINavigationBar.keyIsTranslucent] as? Bool {
                isTranslucent = value
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
			if let value = dic[UINavigationBar.keyTitleTextAttributes] as? [NSAttributedString.Key: Any] {
                titleTextAttributes = value
            }
            if let value = dic[UINavigationBar.keyShadowImage] as? UIImage {
                shadowImage = value
            }
            if let value = dic[UINavigationBar.keyBackIndicatorImage] as? UIImage {
                backIndicatorImage = value
            }
            if let value = dic[UINavigationBar.keyBackgroundImage] as? UIImage {
                setBackgroundImage(value, for: .default)
            }
        }
    }
}

extension UIToolbar: SaveRestore {
    static let keyIsTranslucent = NSStringFromSelector(#selector(getter: isTranslucent))
    static let keyBarStyle = NSStringFromSelector(#selector(getter: barStyle))
    static let keyBarTintColor = NSStringFromSelector(#selector(getter: barTintColor))
    static let keyTintColor = NSStringFromSelector(#selector(getter: tintColor))
    static let keyShadowImage = NSStringFromSelector(#selector(shadowImage(forToolbarPosition:)))
    static let keyBackgroundImage = NSStringFromSelector(#selector(backgroundImage(forToolbarPosition:barMetrics:)))
    
    public func save() {
        associatedObject = [
            UIToolbar.keyIsTranslucent: isTranslucent,
            UIToolbar.keyBarStyle: barStyle,
            UIToolbar.keyBarTintColor: barTintColor as Any,
            UIToolbar.keyTintColor: tintColor as Any,
            UIToolbar.keyShadowImage: shadowImage(forToolbarPosition: .any) as Any,
            UIToolbar.keyBackgroundImage: backgroundImage(forToolbarPosition: .any, barMetrics: .default) as Any,
        ]
    }
    
    public func restore() {
        if let dic = associatedObject as? [String: Any] {
            if let value = dic[UIToolbar.keyIsTranslucent] as? Bool {
                isTranslucent = value
            }
            if let value = dic[UIToolbar.keyBarStyle] as? UIBarStyle {
                barStyle = value
            }
            if let value = dic[UIToolbar.keyBarTintColor] as? UIColor {
                barTintColor = value
            }
            if let value = dic[UIToolbar.keyTintColor] as? UIColor {
                tintColor = value
            }
            if let value = dic[UIToolbar.keyShadowImage] as? UIImage {
                setShadowImage(value, forToolbarPosition: .any)
            }
            if let value = dic[UIToolbar.keyBackgroundImage] as? UIImage {
                setBackgroundImage(value, forToolbarPosition: .any, barMetrics: .default)
            }
        }
    }
}
