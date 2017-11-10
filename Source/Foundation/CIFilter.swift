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
    public enum Kind {
        case CIColorCube
        case CIColorCubeWithColorSpace(CGColorSpace?)
        
        var name: String {
            switch self {
            case .CIColorCube:
                return "CIColorCube"
            case .CIColorCubeWithColorSpace:
                return "CIColorCubeWithColorSpace"
            }
        }
    }
    
    var kind: Kind
    
    override var name: String {
        return kind.name
    }
    
    public init(kind: Kind, cubeDimension: Int, cubeData: Data) {
        self.kind = kind
        super.init()
        
        parameters["inputCubeDimension"] = cubeDimension
        parameters["inputCubeData"] = cubeData
        switch kind {
        case .CIColorCubeWithColorSpace(let cgColorSpace):
            parameters["inputColorSpace"] = cgColorSpace
        default:
            break
        }
    }
    
    // cubeDimension should be divided by 256
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

public final class CIFWGaussianBlur: CIFilterWrapper {
	override var name: String {
		return "CIGaussianBlur"
	}
	
	public init(radius: Float = 10.00) {
		super.init()

		parameters["inputRadius"] = NSNumber(value: radius)	// An NSNumber object whose attribute type is CIAttributeTypeDistance, default is 10.00, range 0.00 - 100.00
	}
}

public final class CIFWVignette: CIFilterWrapper {
	override var name: String {
		return "CIVignette"
	}
	
	public init(radius: Float = 1.0, intensity: Float = 0.0) {
		super.init()

		parameters["inputRadius"] = NSNumber(value: radius)
		parameters["inputIntensity"] = NSNumber(value: intensity)
	}
}
