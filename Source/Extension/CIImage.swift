//
//  CIImage.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/11/7.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public extension CIImage {
    func uiImage(rectForInfinite: CGRect? = nil) -> UIImage? {
        let ciImage: CIImage
        if extent.isInfinite {
            ciImage = cropped(to: rectForInfinite!)
        } else {
            ciImage = self
        }
        let context = CIContext()
        if let cgImage =  context.createCGImage(ciImage, from: ciImage.extent) {
            return UIImage(cgImage: cgImage, scale: 1, orientation: .up)
        } else {
            return nil
        }
    }
    
    func applyingFilter(_ filter: CIFilterWrapper?) -> CIImage {
        if let filter = filter {
            return applyingFilter(filter.name, parameters: filter.parameters)
        } else {
            return self
        }
    }
}
