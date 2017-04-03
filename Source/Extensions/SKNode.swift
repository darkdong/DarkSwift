//
//  SKNode.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/3.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import SpriteKit

extension SKNode: Layoutable, Cloneable {
    public var coordinateSystemOrigin: CoordinateSystemOrigin {
        return .lowerLeft
    }
    
    public var size: CGSize {
        return calculateAccumulatedFrame().size
    }
    
    public var anchorPoint: CGPoint {
        return CGPoint(x: 0.5, y: 0.5)
    }
    
    public func layoutChildren(_ nodes: [SKNode], alignment: Alignment, in rect: CGRect? = nil) {
        let rect = rect ?? CGRect(origin: CGPoint.zero, size: frame.size)
        let positions = SKNode.positions(forItems: nodes, alignment: alignment, in: rect)
        for (node, position) in zip(nodes, positions) {
            node.position = position
        }
    }    
}

