//
//  UIFont.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/7/31.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

// call UIFont.xxxSystemFont or create font UI elements from storyboard, but using specified font instead of system font
// default is PingFangSC

public extension UIFont {
    struct DefaultFontName {
        public static var regular = "PingFangSC-Regular"
        public static var bold = "PingFangSC-Semibold"
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
    
    @objc class func swizzledSystemFont(ofSize size: CGFloat) -> UIFont {
        return font.withSize(size)
    }
    
    @objc class func swizzledBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return boldFont.withSize(size)
    }
    
    @objc class func swizzledItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return italicFont.withSize(size)
    }
    
    @objc convenience init(swizzledCoder aDecoder: NSCoder) {
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            let key = UIFontDescriptor.AttributeName("NSCTFontUIUsageAttribute")
            if let fontAttribute = fontDescriptor.fontAttributes[key] as? String {
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
                self.init(swizzledCoder: aDecoder)
            }
        } else {
            self.init(swizzledCoder: aDecoder)
        }
    }
    
    class func useCustomFontsByCallingSystemFontMethods() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let myFontMethod = class_getClassMethod(self, #selector(swizzledSystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod!, myFontMethod!)
            
            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldFontMethod = class_getClassMethod(self, #selector(swizzledBoldSystemFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod!, myBoldFontMethod!)
            
            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            let myItalicFontMethod = class_getClassMethod(self, #selector(swizzledItalicSystemFont(ofSize:)))
            method_exchangeImplementations(italicSystemFontMethod!, myItalicFontMethod!)
            
            //init form storyboard: borrow signature from UIFontDescriptor.init(coder:)
            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:)))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(swizzledCoder:)))
            method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
        }
    }
}
