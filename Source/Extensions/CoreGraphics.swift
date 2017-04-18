//
//  CoreGraphics.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/30.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import CoreGraphics

public extension CGPoint {
    static func + (point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: point1.x + point2.x, y: point1.y + point2.y)
    }
    
    static func * (point: CGPoint, scale: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scale, y: point.y * scale)
    }
}

public extension CGSize {
    static func + (size1: CGSize, size2: CGSize) -> CGSize {
        return CGSize(width: size1.width + size2.width, height: size1.height + size2.height)
    }
    
    static func * (size: CGSize, scale: CGFloat) -> CGSize {
        return CGSize(width: size.width * scale, height: size.height * scale)
    }
    
    var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2)
    }
}

public extension CGRect {
    init(center: CGPoint, size: CGSize) {
        self = CGRect(origin: center, size: CGSize.zero).insetBy(dx: -size.width / 2, dy: -size.height / 2)
    }
    
    var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
        set {
            origin = CGPoint(x: newValue.x - width / 2, y: newValue.y - height / 2)
        }
    }
    
    var bounds: CGRect {
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
    func rect(byInsets insets: UIEdgeInsets) -> CGRect {
        return CGRect(x: origin.x + insets.left, y: origin.y + insets.top, width: width - insets.left - insets.right, height: height - insets.top - insets.bottom)
    }
}
