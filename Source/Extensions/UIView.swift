//
//  UIView.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/2.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UIView {
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
    
    func capturedImage() -> UIImage? {
        if let context = UIGraphicsGetCurrentContext() {
            UIGraphicsBeginImageContextWithOptions(frame.size, isOpaque, UIScreen.main.scale)
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
        let rect = bounds.rect(byInsets: insets)
        UIView.layoutViews(views, alignment: alignment, in: rect)
    }
}
