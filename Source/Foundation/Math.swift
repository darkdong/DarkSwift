//
//  Math.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/11.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

public struct Math {
    @inline(__always) public static func similarY< T: FloatingPoint >(x1: T, x: T, x2: T, y1: T, y2: T) -> T {
        return x1 == x2 ? y1 : y1 + (x - x1) * (y2 - y1) / (x2 - x1)
    }
    
    @inline(__always) public static func similarY< T: BinaryInteger >(x1: T, x: T, x2: T, y1: T, y2: T) -> T {
        return x1 == x2 ? y1 : y1 + (x - x1) * (y2 - y1) / (x2 - x1)
    }
    
    public static func closestPagingPoint(to point: CGFloat, pageSize: CGFloat, offset: CGFloat = 0) -> CGFloat {
        let index = point / pageSize
        let floorPoint = floor(index) * pageSize + offset
        let ceilPoint = ceil(index) * pageSize + offset
        return abs(floorPoint - point) < abs(ceilPoint - point) ? floorPoint : ceilPoint
    }
    
    //find bit 1 from right to left
    // bitPositions(13) -> 0x00001101 -> [1, 3, 4] 
    public static func bitmaskPositions(_ bitsRepresentation: UInt) -> [Int] {
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
