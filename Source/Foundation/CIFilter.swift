//
//  CIFilter.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/11/7.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public class CIFilterWrapper {
    public var name: String {
        return ""
    }
    public var parameters = [String: Any]()
}

public final class CIFWColorCube: CIFilterWrapper {
    enum Key: String {
        case inputCubeDimension
        case inputCubeData
        case inputColorSpace
    }
    
    public var dimension = 0 {
        didSet {
            let minDimension = 2
            let maxDimension = 128
            if dimension < minDimension {
                dimension = minDimension
            }
            if dimension > maxDimension {
                dimension = maxDimension
            }
            parameters[Key.inputCubeDimension.rawValue] = dimension
        }
    }
    public var data: Data! {
        didSet {
            parameters[Key.inputCubeData.rawValue] = data
        }
    }
    public var colorSpace: CGColorSpace? {
        didSet {
            parameters[Key.inputColorSpace.rawValue] = colorSpace
        }
    }
    
    public init(dimension: Int, data: Data, colorSpace: CGColorSpace?) {
        super.init()
        initParameters(dimension: dimension, data: data, colorSpace: colorSpace)
    }
    
    override public var name: String {
        return "CIColorCubeWithColorSpace"
    }
    
    private func initParameters(dimension: Int, data: Data, colorSpace: CGColorSpace?) {
        self.dimension = dimension
        self.data = data
        self.colorSpace = colorSpace
    }
    
    // cubeDimension should be divided by 256 and >= 2 and <= 128
    public static func standardColorCubeData(cubeDimension: Int) -> Data {
        let components = 4
        let capacity = cubeDimension * cubeDimension * cubeDimension * components
        var data = Data(capacity: capacity)
        let scale = (Int(UInt8.max) + 1) / cubeDimension
        
        func revise(at index: Int) -> Int {
            return Math.similarY(x1: 0, x: index, x2: cubeDimension, y1: 0, y2: scale)
        }
        
        for ib in 0..<cubeDimension {
            for ig in 0..<cubeDimension {
                for ir in 0..<cubeDimension {
                    let r = UInt8(ir * scale + revise(at: ir))
                    let g = UInt8(ig * scale + revise(at: ig))
                    let b = UInt8(ib * scale + revise(at: ib))
                    let rgbaData = Data(bytes: [r, g, b, UInt8.max])
                    data.append(rgbaData)
                }
            }
        }
        return data
    }
}

public final class CIFWConvolution: CIFilterWrapper {
    enum Key: String {
        case inputWeights
        case inputBias
    }
    
    public enum Kind: String {
        case CIConvolution3X3
        case CIConvolution5X5
        case CIConvolution7X7
        case CIConvolution9Horizontal
        case CIConvolution9Vertical
        
        var name: String {
            return rawValue
        }
    }
    
    public var kind: Kind
    public var weights: [CGFloat] = [] {
        didSet {
            parameters[Key.inputWeights.rawValue] = CIVector(values: weights, count: weights.count)
        }
    }
    public var bias: CGFloat = 0 {
        didSet {
            parameters[Key.inputBias.rawValue] = bias
        }
    }
    
    public init(kind: Kind, weights: [CGFloat], bias: CGFloat) {
        self.kind = kind
        super.init()
        
        initParameters(weights: weights, bias: bias)
    }
    
    private func initParameters(weights: [CGFloat], bias: CGFloat) {
        self.weights = weights
        self.bias = bias
    }
    
    override public var name: String {
        return kind.name
    }
}
