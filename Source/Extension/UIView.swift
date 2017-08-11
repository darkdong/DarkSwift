//
//  UIView.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/2.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UIView {
    var width: CGFloat {
        get {
            return frame.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return frame.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    var left: CGFloat {
        get {
            return frame.minX
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var right: CGFloat {
        get {
            return frame.maxX
        }
        set {
            frame.origin.x = newValue - frame.width
        }
    }
    
    var top: CGFloat {
        get {
            return frame.minY
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return frame.maxY
        }
        set {
            frame.origin.y = newValue - frame.height
        }
    }
    
    var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center = CGPoint(x: newValue, y: center.y)
        }
    }
    
    var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center = CGPoint(x: center.x, y: newValue)
        }
    }
    
    func setHeightFromBottom(_ newHeight: CGFloat) {
        frame.origin.y += frame.height - newHeight
        frame.size.height = newHeight
    }
    
    var viewController: UIViewController? {
        var v: UIView? = self
        while v != nil {
            if let vc = v?.next as? UIViewController {
                return vc
            } else {
                v = v?.superview
            }
        }
        return nil
    }
    
    func renderedImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, isOpaque, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        } else {
            return nil
        }
    }
    
    func clips(to path: UIBezierPath) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}

extension UIView: Layoutable {
    public var coordinateSystemOrigin: CoordinateSystemOrigin {
        return .upperLeft
    }
    
    public var size: CGSize {
        return frame.size
    }
    
    public var anchorPoint: CGPoint {
        return CGPoint.zero
    }
    
    public static func layoutViews(_ views: [UIView], alignment: Alignment, in rect: CGRect) {
        let points = positions(forItems: views, alignment: alignment, in: rect)
        for (view, point) in zip(views, points) {
            view.frame.origin = point
        }
    }
    
    public func layoutSubviews(_ views: [UIView], alignment: Alignment, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        let rect = bounds.inset(insets)
        UIView.layoutViews(views, alignment: alignment, in: rect)
    }
}
