//
//  CoreGraphics.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/30.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import CoreGraphics

public extension CGPoint {
    static func distance(_ p1: CGPoint, p2: CGPoint) -> CGFloat {
        return sqrt(distance2(p1, p2))
    }
    
    static func distance2(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
        let dx = p2.x - p1.x
        let dy = p2.y - p1.y
        return dx * dx + dy * dy
    }
    
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    static func * (point: CGPoint, scale: CGFloat) -> CGPoint {
        let t = CGAffineTransform(scaleX: scale, y: scale)
        return point.applying(t)
    }
    
    static func center(point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
    }
    
    func flipped(height: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: height - y)
    }
}

public extension CGSize {
    static func + (left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.width + right.width, height: left.height + right.height)
    }
    
    static func - (left: CGSize, right: CGSize) -> CGSize {
        return CGSize(width: left.width - right.width, height: left.height - right.height)
    }
    
    static func * (size: CGSize, scale: CGFloat) -> CGSize {
        let t = CGAffineTransform(scaleX: scale, y: scale)
        return size.applying(t)
    }
    
    static func / (size: CGSize, scale: CGFloat) -> CGSize {
        return size * (1 / scale)
    }
    
    var center: CGPoint {
        return CGPoint(x: width / 2, y: height / 2)
    }
}

public extension CGRect {
    static func * (rect: CGRect, scale: CGFloat) -> CGRect {
        let t = CGAffineTransform(scaleX: scale, y: scale)
        return rect.applying(t)
    }
    
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
    
    var topRight: CGPoint {
        get {
            return CGPoint(x: maxX, y: minY)
        }
        set {
            origin = CGPoint(x: newValue.x - width, y: newValue.y)
        }
    }
    
    var bottomLeft: CGPoint {
        get {
            return CGPoint(x: minX, y: maxY)
        }
        set {
            origin = CGPoint(x: newValue.x, y: newValue.y - height)
        }
    }
    
    var bottomRight: CGPoint {
        get {
            return CGPoint(x: maxX, y: maxY)
        }
        set {
            origin = CGPoint(x: newValue.x - width, y: newValue.y - height)
        }
    }
    
    var bounds: CGRect {
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
    func insetBy(edgeInsets: UIEdgeInsets) -> CGRect {
        return CGRect(x: origin.x + edgeInsets.left, y: origin.y + edgeInsets.top, width: width - edgeInsets.left - edgeInsets.right, height: height - edgeInsets.top - edgeInsets.bottom)
    }
}

public extension UIEdgeInsets {
    static func + (left: UIEdgeInsets, right: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: left.top + right.top, left: left.left + right.left, bottom: left.bottom + right.bottom, right: left.right + right.right)
    }
    
    static func += (left: inout UIEdgeInsets, right: UIEdgeInsets) {
        left = left + right
    }
}
