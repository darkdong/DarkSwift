//
//  String.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/28.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public extension String {
    var version: OperatingSystemVersion {
        let versions = components(separatedBy: ".")
        
        var major = 0
        if versions.count > 0 {
            major = (versions[0] as NSString).integerValue
        }
        
        var minor = 0
        if versions.count > 1 {
            minor = (versions[1] as NSString).integerValue
        }
        
        var patch = 0
        if versions.count > 2 {
            patch = (versions[2] as NSString).integerValue
        }
        
        return OperatingSystemVersion(majorVersion: major, minorVersion: minor, patchVersion: patch)
    }
    
    func hash(algorithm: Data.DigestAlgorithm, lowercase: Bool = true) -> String {
        return data(using: .utf8)!.hash(algorithm: algorithm, lowercase: lowercase)
    }

    func hmac(algorithm: Data.DigestAlgorithm, key: String, lowercase: Bool = true) -> String {
        return data(using: .utf8)!.hmac(algorithm: algorithm, keyData: key.data(using: .utf8)!, lowercase: lowercase)
    }
    
    func attributedString(font: UIFont? = nil, color: UIColor? = nil) -> NSMutableAttributedString {
        var attributes = [NSAttributedString.Key: Any]()
        
        if let font = font {
            attributes[.font] = font
        }
        if let color = color {
            attributes[.foregroundColor] = color
        }
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
}

public extension NSMutableAttributedString {
    @discardableResult
    func addUnderline(style: NSUnderlineStyle, color: UIColor) -> Self {
        let range = totalRange
        addAttribute(.underlineStyle, value: style.rawValue, range: range)
        addAttribute(.underlineColor, value: color, range: range)
        return self
    }
    
    @discardableResult
    func addStrikethrough(style: NSUnderlineStyle, color: UIColor) -> Self {
        let range = totalRange
        addAttribute(.baselineOffset, value: 0, range: range)
        addAttribute(.strikethroughStyle, value: style.rawValue, range: range)
        addAttribute(.strikethroughColor, value: color, range: range)
        return self
    }
    
    @discardableResult
    func addParagraghStyle(_ paragraphStyle: NSParagraphStyle) -> Self {
        let range = totalRange
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        return self
    }
    
    private var totalRange: NSRange {
        return NSRange(location: 0, length: length)
    }
}
