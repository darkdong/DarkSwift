//
//  Math.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/11.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

public protocol FloatingType: Equatable, Comparable {
    static func +(lhs: Self, rhs: Self) -> Self
    static func -(lhs: Self, rhs: Self) -> Self
    static func *(lhs: Self, rhs: Self) -> Self
    static func /(lhs: Self, rhs: Self) -> Self
    static func %(lhs: Self, rhs: Self) -> Self
}
extension CGFloat: FloatingType { }
extension Double : FloatingType { }
extension Float  : FloatingType { }

public class Math: NSObject {
    @inline(__always) public static func similarY< T: FloatingType >(x1: T, x: T, x2: T, y1: T, y2: T) -> T {
        return x1 == x2 ? y1 : y1 + (x - x1) * (y2 - y1) / (x2 - x1)
    }
    
    @inline(__always) public static func random(greatThanOrEqualTo lower: Int = 0, lessThan upper: Int) -> Int {
        return Int(arc4random_uniform(UInt32(upper - lower))) + lower
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
