//
//  ScrollViewPaging.swift
//  polaroid
//
//  Created by Dark Dong on 2017/12/21.
//  Copyright © 2017年 Dora Technology. All rights reserved.
//

import Foundation

public enum ScrollViewPagingMode {
    case custom([CGFloat])
    case page(CGFloat)
}

public protocol ScrollViewPaging {
    var mode: ScrollViewPagingMode { get }
}

public extension ScrollViewPaging {
    func closestPagingPoint(to point: CGFloat) -> CGFloat {
        switch mode {
        case .custom( let sortedPagingPoints):
            let closestPoint = sortedPagingPoints.min { (pagingPoint1, pagingPoint2) -> Bool in
                return abs(pagingPoint1 - point) < abs(pagingPoint2 - point)
            }
            return closestPoint!
        case .page(let pageSize):
            return Math.closestPagingPoint(to: point, pageSize: pageSize)
        }
    }
    
    func nextPagingPoint(from point: CGFloat, velocity: CGFloat) -> CGFloat {
        guard velocity != 0 else {
            return closestPagingPoint(to: point)
        }
        
        switch mode {
        case .custom( let sortedPagingPoints):
            guard point > sortedPagingPoints.first! else {
                return sortedPagingPoints.first!
            }
            
            guard point < sortedPagingPoints.last! else {
                return sortedPagingPoints.last!
            }
            
            let index2 = sortedPagingPoints.index(where: { (pagingPoint) -> Bool in
                return point < pagingPoint
            })!
            
            let index1 = sortedPagingPoints.index(before: index2)
            return velocity < 0 ? sortedPagingPoints[index1] : sortedPagingPoints[index2]
        case .page(let pageSize):
            let floatIndex = point / pageSize
            let floorPoint = floor(floatIndex) * pageSize
            let ceilPoint = ceil(floatIndex) * pageSize
            return velocity < 0 ? floorPoint : ceilPoint
        }
    }
}
