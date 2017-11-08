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

    public init(cubeSize: Int, cubeData: Data) {
        super.init()
        
        parameters["inputCubeDimension"] = cubeSize
        parameters["inputCubeData"] = cubeData
    }
    
    public static func standardCubeData(cubeSize: Int) -> Data {
        let components = 4
        let capacity = cubeSize * cubeSize * cubeSize * components
        var data = Data(capacity: capacity)
        for ib in 0..<cubeSize {
            for ig in 0..<cubeSize {
                for ir in 0..<cubeSize {
                    let r = UInt8(ir * cubeSize + ir)
                    let g = UInt8(ig * cubeSize + ig)
                    let b = UInt8(ib * cubeSize + ib)
                    data.append(Data(bytes: [r, g, b, UInt8.max]))
                }
            }
        }
        return data
//            var floats = [Float]()
//            floats.reserveCapacity(capacity)
//            for ib in 0..<cubeSize {
//                for ig in 0..<cubeSize {
//                    for ir in 0..<cubeSize {
//                        let r = Float(ir) / Float(cubeSize - 1)
//                        let g = Float(ig) / Float(cubeSize - 1)
//                        let b = Float(ib) / Float(cubeSize - 1)
//                        floats.append(r)
//                        floats.append(g)
//                        floats.append(b)
//                        floats.append(1)
//                    }
//                }
//            }
//            return Data(buffer: UnsafeBufferPointer(start: &floats, count: floats.count))
    }
}
