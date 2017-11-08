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
    
    public static func standardColorCubeData(dimension: Int) -> Data {
        let components = 4
        let capacity = dimension * dimension * dimension * components
        var data = Data(capacity: capacity)
        for ib in 0..<dimension {
            for ig in 0..<dimension {
                for ir in 0..<dimension {
                    let r = UInt8(ir * dimension + ir)
                    let g = UInt8(ig * dimension + ig)
                    let b = UInt8(ib * dimension + ib)
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
    
    //MARK: FIXME bias must be 0, or crash when convert CIImage to UIImage because CIImage's extent is infinite
    public init(kind: Kind, weights: [CGFloat], bias: CGFloat = 0) {
        self.kind = kind
        super.init()
        
        parameters["inputWeights"] = CIVector(values: weights, count: weights.count)
        parameters["inputBias"] = bias
    }
}
