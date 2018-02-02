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
    
    func applyingFilter(_ filter: ImageFilter?) -> CIImage {
        if let filter = filter, filter.isEnabled {
            return applyingFilter(filter.name, parameters: filter.parameters)
        } else {
            return self
        }
    }
    
    func applyingAlpha(_ alpha: CGFloat) -> CIImage {
        let name = "CIConstantColorGenerator"
        let key = "inputColor"
        let backgroundFilter = CIFilter(name: name)!
        backgroundFilter.setValue(CIColor(red: 0, green: 0, blue: 0, alpha: 0), forKey: key)
        let backgroundImage = backgroundFilter.outputImage!
        
        let alphaFilter = CIFilter(name: name)!
        alphaFilter.setValue(CIColor(red: 0, green: 0, blue: 0, alpha: alpha), forKey: key)
        let alphaImage = alphaFilter.outputImage!
        
        let parameters: [String: Any] = [
            "inputBackgroundImage": backgroundImage,
            "inputMaskImage": alphaImage
        ]
        return applyingFilter("CIBlendWithAlphaMask", parameters: parameters)
    }
}
