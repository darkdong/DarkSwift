//
//  Layout.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/2.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

public protocol Layoutable {
    var coordinateSystemOrigin: CoordinateSystemOrigin { get }
    var size: CGSize { get }
    var anchorPoint: CGPoint { get }
}

public extension Layoutable {
    static func positions(forItems items: [Layoutable], alignment: Alignment, in rect: CGRect) -> [CGPoint] {
        let cpoints: [CGPoint]
        switch alignment {
        case let .horizontal(verticalAlignment):
            cpoints = horizontalCenterPoints(forItems: items, in: rect, verticalAlignment: verticalAlignment)
        case let.vertical(horizontalAlignment):
            cpoints = verticalCenterPoints(forItems: items, in: rect, horizontalAlignment: horizontalAlignment)
        case let .tabular(numberOfRows, numberOfColumns, itemSize):
            cpoints = tabularCenterPoints(forItemSize: itemSize, numberOfTableRows: numberOfRows, numberOfTableColumns: numberOfColumns, in: rect)
        }
        var points: [CGPoint] = []
        for (cpoint, item) in zip(cpoints, items) {
            let point = item.convertCenterPoint(cpoint)
            points.append(point)
        }
        return points
    }
    
    static func horizontalCenterPoints(forItems items: [Layoutable], in rect: CGRect, verticalAlignment: UIControlContentVerticalAlignment = .center) -> [CGPoint] {
        if items.isEmpty {
            return []
        } else if items.count == 1 {
            let cpoint = items[0].centerPoint(in: rect, verticalAlignment: verticalAlignment)
            return [cpoint]
        } else {
            var cpoints: [CGPoint] = []
            let sumOfWidths = sum(ofItems: items) { $0.size.width }
            let numberOfSpacings = items.count - 1
            let spacing = (rect.width - sumOfWidths) / CGFloat(numberOfSpacings)
            let spacings = [0] + [CGFloat](repeating: spacing, count: numberOfSpacings)
            var lastItemX = rect.minX
            for (spacing, item) in zip(spacings, items) {
                let cx = lastItemX + spacing + item.size.width/2
                let cy = item.centerY(in: rect, verticalAlignment: verticalAlignment)
                let cpoint = CGPoint(x: cx, y: cy)
                cpoints.append(cpoint)
                lastItemX = cx + item.size.width/2
            }
            return cpoints
        }
    }
    
    static func verticalCenterPoints(forItems items: [Layoutable], in rect: CGRect, horizontalAlignment: UIControlContentHorizontalAlignment = .center) -> [CGPoint] {
        if items.isEmpty {
            return []
        } else if items.count == 1 {
            let cpoint = items[0].centerPoint(in: rect, horizontalAlignment: horizontalAlignment)
            return [cpoint]
        } else {
            var cpoints: [CGPoint] = []
            let sumOfHeights = sum(ofItems: items) { $0.size.height }
            let numberOfSpacings = items.count - 1
            let spacing = (rect.height - sumOfHeights) / CGFloat(numberOfSpacings)
            let spacings = [0] + [CGFloat](repeating: spacing, count: numberOfSpacings)
            var lastItemY = rect.minY
            for (spacing, item) in zip(spacings, items) {
                let cx = item.centerX(in: rect, horizontalAlignment: horizontalAlignment)
                let cy = lastItemY + spacing + item.size.height/2
                let cpoint = CGPoint(x: cx, y: cy)
                cpoints.append(cpoint)
                lastItemY = cy + item.size.height/2
            }
            return cpoints
        }
    }
    
    static func tabularCenterPoints(forItemSize itemSize: CGSize, numberOfTableRows: Int, numberOfTableColumns: Int, in rect: CGRect) -> [CGPoint] {
        var cpoints: [CGPoint] = []
        let rowRectSize = CGSize(width: rect.width, height: rect.height / CGFloat(numberOfTableRows))
        var rowRects: [CGRect] = []
        for row in 0..<numberOfTableRows {
            let origin = CGPoint(x: rect.minX, y: rect.minY + CGFloat(row) * rowRectSize.height)
            let rowRect = CGRect(origin: origin, size: rowRectSize)
            rowRects.append(rowRect)
        }
        
        let item = LayoutableItem(size: itemSize)
        let items = [LayoutableItem](repeating: item, count: numberOfTableColumns)
        for rect in rowRects {
            let rowCenterPoints = horizontalCenterPoints(forItems: items, in: rect)
            cpoints.append(contentsOf: rowCenterPoints)
        }
        return cpoints
    }
    
    static func sum(ofItems items: [Layoutable], on attributeValue: (Layoutable) -> CGFloat) -> CGFloat {
        return items.reduce(0) { (accumulatedValue, item) -> CGFloat in
            return accumulatedValue + attributeValue(item)
        }
    }

    func centerX(in rect: CGRect, horizontalAlignment: UIControlContentHorizontalAlignment = .center) -> CGFloat {
        switch horizontalAlignment {
        case .left:
            return rect.minX + size.width/2
        case .right:
            return rect.maxX - size.width/2
        default:
            return rect.midX
        }
    }
    
    func centerY(in rect: CGRect, verticalAlignment: UIControlContentVerticalAlignment = .center) -> CGFloat {
        switch verticalAlignment {
        case .top:
            return coordinateSystemOrigin == .upperLeft ? rect.minY + size.height/2 : rect.maxY - size.height/2
        case .bottom:
            return coordinateSystemOrigin == .upperLeft ? rect.maxY - size.height/2 : rect.minY + size.height/2
        default:
            return rect.midY
        }
    }
    
    func centerPoint(in rect: CGRect, horizontalAlignment: UIControlContentHorizontalAlignment = .center, verticalAlignment: UIControlContentVerticalAlignment = .center) -> CGPoint {
        let cx = centerX(in: rect, horizontalAlignment: horizontalAlignment)
        let cy = centerY(in: rect, verticalAlignment: verticalAlignment)
        return CGPoint(x: cx, y: cy)
    }
    
    func convertCenterPoint(_ centerPoint: CGPoint) -> CGPoint {
        let dx = (anchorPoint.x - 0.5) * size.width
        let dy = (anchorPoint.y - 0.5) * size.height
        return CGPoint(x: centerPoint.x + dx, y: centerPoint.y + dy)
    }
}

struct LayoutableItem: Layoutable {
    var size: CGSize
    var anchorPoint: CGPoint
    var coordinateSystemOrigin: CoordinateSystemOrigin
    
    init(size: CGSize = CGSize.zero, anchorPoint: CGPoint = CGPoint.zero, coordinateSystemOrigin: CoordinateSystemOrigin = .upperLeft) {
        self.size = size
        self.anchorPoint = anchorPoint
        self.coordinateSystemOrigin = coordinateSystemOrigin
    }
}

public enum CoordinateSystemOrigin {
    case upperLeft, lowerLeft
}

public enum Alignment {
    case horizontal(UIControlContentVerticalAlignment)
    case vertical(UIControlContentHorizontalAlignment)
    case tabular(Int, Int, CGSize)
}
