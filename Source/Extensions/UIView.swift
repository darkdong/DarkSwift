//
//  UIView.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/2.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

extension UIView: Layoutable {
    public var size: CGSize {
        return frame.size
    }
    
    public var anchorPoint: CGPoint {
        return CGPoint.zero
    }
    
    static func pointX(forItem item: Layoutable, in rect: CGRect, horizontalAlignment: UIControlContentHorizontalAlignment = .center) -> CGFloat {
        switch horizontalAlignment {
        case .left:
            return rect.minX
        case .right:
            return rect.maxX - item.size.width
        default:
            return rect.midX - item.size.width / 2
        }
    }
    
    static func pointY(forItem item: Layoutable, in rect: CGRect, verticalAlignment: UIControlContentVerticalAlignment = .center) -> CGFloat {
        switch verticalAlignment {
        case .top:
            return rect.minY
        case .bottom:
            return rect.maxY - item.size.height
        default:
            return rect.midY - item.size.height / 2
        }
    }
    
    public static func position(forItem item: Layoutable, in rect: CGRect, horizontalAlignment: UIControlContentHorizontalAlignment = .center, verticalAlignment: UIControlContentVerticalAlignment = .center) -> CGPoint {
        let x = pointX(forItem: item, in: rect, horizontalAlignment: horizontalAlignment)
        let y = pointY(forItem: item, in: rect, verticalAlignment: verticalAlignment)
        return CGPoint(x: x + item.dx, y: y + item.dy)
    }
    
    public static func positions(forHorizontalItems items: [Layoutable], in rect: CGRect, verticalAlignment: UIControlContentVerticalAlignment = .center) -> [CGPoint] {
        if items.isEmpty {
            return []
        }else if items.count == 1 {
            let point = position(forItem: items[0], in: rect, verticalAlignment: verticalAlignment)
            return [point]
        }else {
            var points = [CGPoint]()
            let sumOfWidths = sum(ofItems: items) { $0.size.width }
            let numberOfSpacings = items.count - 1
            let defaultSpacing = (rect.width - sumOfWidths) / CGFloat(numberOfSpacings)
            let defaultSpacings = [CGFloat](repeating: defaultSpacing, count: numberOfSpacings)
            
            var x = rect.minX
            var spacingGenerator = defaultSpacings.makeIterator()
            
            for item in items {
                let y = pointY(forItem: item, in: rect, verticalAlignment: verticalAlignment)
                let point = CGPoint(x: x + item.dx, y: y + item.dy)
                points.append(point)
                let spacing = spacingGenerator.next() ?? 0
                x += item.size.width + spacing
            }
            return points
        }
    }
    
    public static func positions(forVerticalItems items: [Layoutable], in rect: CGRect, horizontalAlignment: UIControlContentHorizontalAlignment = .center) -> [CGPoint] {
        if items.isEmpty {
            return []
        }else if items.count == 1 {
            let point = position(forItem: items[0], in: rect, horizontalAlignment: horizontalAlignment)
            return [point]
        }else {
            var points = [CGPoint]()
            let sumOfHeights = sum(ofItems: items) { $0.size.height }
            let numberOfSpacings = items.count - 1
            let defaultSpacing = (rect.height - sumOfHeights) / CGFloat(numberOfSpacings)
            let defaultSpacings = [CGFloat](repeating: defaultSpacing, count: numberOfSpacings)
            
            var y = rect.minY
            var spacingGenerator = defaultSpacings.makeIterator()
            
            for item in items {
                let x = pointX(forItem: item, in: rect, horizontalAlignment: horizontalAlignment)
                let point = CGPoint(x: x + item.dx, y: y + item.dy)
                points.append(point)
                let spacing = spacingGenerator.next() ?? 0
                y += item.size.height + spacing
            }
            return points
        }
    }
    
    public static func positions(forTabularItems items: [Layoutable], numberOfTableRows: Int, numberOfTableColumns: Int, in rect: CGRect) -> [CGPoint] {
        var centerPoints: [CGPoint] = []
        let dx = rect.width / CGFloat(numberOfTableColumns + 1)
        let dy = rect.height / CGFloat(numberOfTableRows + 1)
        for row in 1...numberOfTableRows {
            for col in 1...numberOfTableColumns {
                let x = rect.minX + dx * CGFloat(col)
                let y = rect.minY + dy * CGFloat(row)
                let point = CGPoint(x: x , y: y)
                centerPoints.append(point)
            }
        }
        
        var points: [CGPoint] = []
        for (centerPoint, item) in zip(centerPoints, items) {
            let point = CGPoint(x: centerPoint.x - item.size.width/2, y: centerPoint.y - item.size.height/2)
            points.append(point)
        }
        return points
    }
    
    public func layout(views: [UIView], alignment: Alignment, in rect: CGRect? = nil, shouldAddSubview: Bool = false) {
        let rect = rect ?? CGRect(origin: CGPoint.zero, size: frame.size)
        let positions: [CGPoint]
        switch alignment {
        case .horizontal(let verticalAlignment):
            positions = UIView.positions(forHorizontalItems: views, in: rect, verticalAlignment: verticalAlignment)
        case .vertical(let horizontalAlignment):
            positions = UIView.positions(forVerticalItems: views, in: rect, horizontalAlignment: horizontalAlignment)
        case .tabular(let numberOfRows, let numberOfColumns):
            positions = UIView.positions(forTabularItems: views, numberOfTableRows: numberOfRows, numberOfTableColumns: numberOfColumns, in: rect)
        }
        for (view, position) in zip(views, positions) {
            view.frame.origin = position
            if shouldAddSubview {
                addSubview(view)
            }
        }
    }
    
    public var xCenter: CGFloat {
        get {
            return center.x
        }
        set {
            center = CGPoint(x: newValue, y: center.y)
        }
    }
    
    public var yCenter: CGFloat {
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
    
    public func clone() -> UIView {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! UIView
    }
}
