//
//  CIImage.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/11/7.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public extension CIImage {
    var uiImage: UIImage {
        let context = CIContext()
        let cgImage =  context.createCGImage(self, from: extent)!
        return UIImage(cgImage: cgImage, scale: 1, orientation: .up)
    }
    
    func applyingFilterWrapper(_ filterWrapper: CIFilterWrapper?) -> CIImage {
        if let filterWrapper = filterWrapper {
            return applyingFilter(filterWrapper.name, parameters: filterWrapper.parameters)
        } else {
            return self
        }
    }
}
