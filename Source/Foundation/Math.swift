//
//  Math.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/11.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public struct Math {
    //find bit 1 from right to left
    // bitPositions(13) -> [1, 2, 4]
    public func bitmaskPositions(_ bitsRepresentation: UInt) -> [Int] {
        if bitsRepresentation != 0 {
            var bits = bitsRepresentation
            var positions: [Int] = []
            var position = 1
            while bits != 0 {
                if bits & 1 != 0 {
                    positions.append(position)
                }
                bits >>= 1
                position += 1
            }
            return positions
        }else {
            return []
        }
    }
}
