//
//  UIView.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/2.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

extension UIView: Layoutable, Cloneable {
    public var coordinateSystemOrigin: CoordinateSystemOrigin {
        return .upperLeft
    }
    
    public var size: CGSize {
        return frame.size
    }
    
    public var anchorPoint: CGPoint {
        return CGPoint.zero
    }
    
    public func layoutSubviews(_ views: [UIView], alignment: Alignment, in rect: CGRect? = nil) {
        let rect = rect ?? CGRect(origin: CGPoint.zero, size: frame.size)
        let positions = UIView.positions(forItems: views, alignment: alignment, in: rect)
        for (view, position) in zip(views, positions) {
            view.frame.origin = position
        }
    }
    
    public var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center = CGPoint(x: newValue, y: center.y)
        }
    }
    
    public var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center = CGPoint(x: center.x, y: newValue)
        }
    }

    public func setHeightFromBottom(_ newHeight: CGFloat) {
        frame.origin.y += frame.height - newHeight
        frame.size.height = newHeight
    }
    
    public var viewController: UIViewController? {
        var v: UIView? = self
        while v != nil {
            if let vc = v?.next as? UIViewController {
                return vc
            }else {
                v = v?.superview
            }
        }
        return nil
    }    
}