//
//  UIFont.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/7/31.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UIFont {
    public struct DefaultFontName {
        public static var regular = "PingFangSC-Regular"
        public static var bold = "PingFangSC-Medium"
        public static var italic = "PingFangSC-Thin"
    }
    
    static private let size: CGFloat = 17
    static private var font: UIFont = {
        let fd = UIFontDescriptor(name: DefaultFontName.regular, size: size)
        return UIFont(descriptor: fd, size: size)
    }()
    static private var boldFont: UIFont = {
        let fd = UIFontDescriptor(name: DefaultFontName.bold, size: size)
        return UIFont(descriptor: fd, size: size)
    }()
    static private var italicFont: UIFont = {
        let fd = UIFontDescriptor(name: DefaultFontName.italic, size: size)
        return UIFont(descriptor: fd, size: size)
    }()
    
    class func defaultFont(ofSize size: CGFloat) -> UIFont {
        return font.withSize(size)
    }
    
    class func boldDefaultFont(ofSize size: CGFloat) -> UIFont {
        return boldFont.withSize(size)
    }
    
    class func italicDefaultFont(ofSize size: CGFloat) -> UIFont {
        return italicFont.withSize(size)
    }
    
    convenience init(myCoder aDecoder: NSCoder) {
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            if let fontAttribute = fontDescriptor.fontAttributes["NSCTFontUIUsageAttribute"] as? String {
                var fontName = ""
                switch fontAttribute {
                case "CTFontRegularUsage":
                    fontName = DefaultFontName.regular
                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                    fontName = DefaultFontName.bold
                case "CTFontObliqueUsage":
                    fontName = DefaultFontName.italic
                default:
                    fontName = DefaultFontName.regular
                }
                let size = fontDescriptor.pointSize
                let fd = UIFontDescriptor(name: fontName, size: size)
                self.init(descriptor: fd, size: size)
            } else {
                self.init(myCoder: aDecoder)
            }
        } else {
            self.init(myCoder: aDecoder)
        }
    }
    
    class func overrideInitialize() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let myFontMethod = class_getClassMethod(self, #selector(defaultFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod, myFontMethod)
            
            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldFontMethod = class_getClassMethod(self, #selector(boldDefaultFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod, myBoldFontMethod)
            
            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            let myItalicFontMethod = class_getClassMethod(self, #selector(italicDefaultFont(ofSize:)))
            method_exchangeImplementations(italicSystemFontMethod, myItalicFontMethod)
            
            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))) // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:)))
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
