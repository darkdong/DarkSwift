//
//  SKNode.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/3.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import SpriteKit

extension SKNode: Layoutable {
    public var coordinateSystemOrigin: CoordinateSystemOrigin {
        return .lowerLeft
    }
    
    public var size: CGSize {
        return calculateAccumulatedFrame().size
    }
    
    public var anchorPoint: CGPoint {
        return CGPoint(x: 0.5, y: 0.5)
    }
    
    public static func layoutNodes(_ nodes: [SKNode], alignment: Alignment, in rect: CGRect) {
        let points = positions(forItems: nodes, alignment: alignment, in: rect)
        for (node, point) in zip(nodes, points) {
            node.position = point
        }
    }
    
//    public func layoutChildren(_ nodes: [SKNode], alignment: Alignment, insets: UIEdgeInsets = UIEdgeInsets.zero) {
//        let rect = frame.bounds.rect(byInsets: insets)
//        SKNode.layoutNodes(nodes, alignment: alignment, in: rect)
//    }    
}

