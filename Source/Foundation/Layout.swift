//
//  Layout.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/2.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public protocol Layoutable {
    var size: CGSize { get}
    var anchorPoint: CGPoint { get }
}

public extension Layoutable {
    static func sum(ofItems items: [Layoutable], on attributeValue: (Layoutable) -> CGFloat) -> CGFloat {
        let sum = items.reduce(0, { (accumulatedValue, item) -> CGFloat in
            return accumulatedValue + attributeValue(item)
        })
        return sum
    }
    
    var dx: CGFloat {
        return anchorPoint.x * size.width
    }
    
    var dy: CGFloat {
        return anchorPoint.y * size.height
    }
}

public enum Alignment {
    case horizontal(UIControlContentVerticalAlignment)
    case vertical(UIControlContentHorizontalAlignment)
    case tabular(Int, Int)
}
