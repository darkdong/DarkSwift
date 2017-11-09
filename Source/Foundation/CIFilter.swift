//
//  CIFilter.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/11/7.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public class CIFilterWrapper {
    var name: String {
        return ""
    }
    var parameters = [String: Any]()
}

public final class CIFWColorCube: CIFilterWrapper {
    override var name: String {
        return "CIColorCube"
    }

    public init(cubeDimension: Int, cubeData: Data) {
        super.init()
        
        parameters["inputCubeDimension"] = cubeDimension
        parameters["inputCubeData"] = cubeData
    }
    
    // cubeDimension should be divided by 256
    public static func standardColorCubeData(cubeDimension: Int) -> Data {
        let dimension = UInt8(cubeDimension)
        let components = 4
        let capacity = cubeDimension * cubeDimension * cubeDimension * components
        var data = Data(capacity: capacity)
        let step = UInt8.max / dimension
        for ib in 0..<dimension {
            for ig in 0..<dimension {
                for ir in 0..<dimension {
                    let r = ir * step + Math.similarY(x1: 0, x: ir, x2: dimension, y1: 0, y2: step)
                    let g = ig * step + Math.similarY(x1: 0, x: ig, x2: dimension, y1: 0, y2: step)
                    let b = ib * step + Math.similarY(x1: 0, x: ib, x2: dimension, y1: 0, y2: step)
                    data.append(Data(bytes: [r, g, b, UInt8.max]))
                }
            }
        }
        return data
    }
}

public final class CIFWConvolution: CIFilterWrapper {
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
    
    var kind: Kind
    
    override var name: String {
        return kind.name
    }
    
    //MARK: FIXME bias must be 0, or crash when converting CIImage to UIImage because CIImage's extent is infinite
    public init(kind: Kind, weights: [CGFloat], bias: CGFloat = 0) {
        self.kind = kind
        super.init()
        
        parameters["inputWeights"] = CIVector(values: weights, count: weights.count)
        parameters["inputBias"] = bias
    }
}
