//
//  ImageFilter.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/11/7.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public class ImageFilter {
    public private(set) var name: String
    public var parameters: [String: Any]
    public var isEnabled = true

    public init(name: String, parameters: [String: Any] = [:]) {
        self.name = name
        self.parameters = parameters
    }
}

public final class ImageColorCubeFilter: ImageFilter {
    enum Key: String {
        case inputCubeDimension
        case inputCubeData
        case inputColorSpace
    }
    
    public var dimension = 0 {
        didSet {
            let min = 2
            let max = 128
            if dimension < min {
                dimension = min
            }
            if dimension > max {
                dimension = max
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
    
    public init(dimension: Int = 2, data: Data, colorSpace: CGColorSpace? = nil) {
        super.init(name: "CIColorCubeWithColorSpace")
        
        func initParameters(dimension: Int, data: Data, colorSpace: CGColorSpace?) {
            self.dimension = dimension
            self.data = data
            self.colorSpace = colorSpace
        }
        
        initParameters(dimension: dimension, data: data, colorSpace: colorSpace)
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
                    let rgbaData = Data([r, g, b, UInt8.max])
                    data.append(rgbaData)
                }
            }
        }
        return data
    }
}
public final class ImageConvolutionFilter: ImageFilter {
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
    
    public init(kind: Kind, weights: [CGFloat], bias: CGFloat = 0) {
        self.kind = kind
        super.init(name: kind.rawValue)

        func initParameters(weights: [CGFloat], bias: CGFloat) {
            self.weights = weights
            self.bias = bias
        }
        
        initParameters(weights: weights, bias: bias)
    }
}

public final class ImageGaussianBlurFilter: ImageFilter {
    enum Key: String {
        case inputRadius
    }
    
    public var radius: Float = 10 {
        didSet {
            parameters[Key.inputRadius.rawValue] = radius
        }
    }
    
    public init(radius: Float = 10) {
        super.init(name: "CIGaussianBlur")

        func initParameters(radius: Float) {
            self.radius = radius
        }
        
        initParameters(radius: radius)
    }
}

public final class ImageVignetteFilter: ImageFilter {
    enum Key: String {
        case inputRadius
        case inputIntensity
    }
    
    public var radius: Float = 1 {
        didSet {
            parameters[Key.inputRadius.rawValue] = radius
        }
    }
    public var intensity: Float = 0 {
        didSet {
            parameters[Key.inputIntensity.rawValue] = intensity
        }
    }
    
    public init(radius: Float = 1, intensity: Float = 0) {
        super.init(name: "CIVignette")

        func initParameters(radius: Float, intensity: Float) {
            self.radius = radius
            self.intensity = intensity
        }
        
        initParameters(radius: radius, intensity: intensity)
    }
}
