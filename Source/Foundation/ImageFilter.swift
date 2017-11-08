//
//  Filter.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/11/7.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public class ImageFilter {
    var name: String {
        return ""
    }
    var parameters = [String: Any]()
}

final class ColorCubeFilter: ImageFilter {
    override var name: String {
        return "CIColorCube"
    }

    init(cubeSize: Int, cubeData: Data) {
        super.init()
        
        parameters["inputCubeDimension"] = cubeSize
        parameters["inputCubeData"] = cubeData
    }
}
