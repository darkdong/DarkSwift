//
//  UIImage.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/18.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

extension UIImage {
//    @nonobjc static let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
    
    convenience init?(contentsOfFilename name: String, inDirectory directoryURL: URL? = Bundle.main.resourceURL) {
        if let imageURL = directoryURL?.appendingPathComponent(name) {
            //demo@2x~ipad.png
            //init contentsOfFile will look for image name with proper modifier such as: @2x, @3x, ~ipad, ~iphone, etc
            //system use "png" in case insensitive as default extension, if extension does not exists
            //You must use explicit extension if image is not "png", e.g. "mypic.jpg" and @nx still works like charm
            self.init(contentsOfFile: imageURL.path)
        }else {
            self.init(data: Data())
        }
    }
    
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: image.cgImage!)
    }
    
    func resizableImage(topInset: CGFloat? = nil, leftInset: CGFloat? = nil) -> UIImage {
        let top: CGFloat
        if let topInset = topInset {
            top = topInset
        }else {
            top = size.height / 2
        }
        let bottom = size.height - top
        
        let left: CGFloat
        if let leftInset = leftInset {
            left = leftInset
        }else {
            left = size.width / 2
        }
        let right = size.width - left
        
        let insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return resizableImage(withCapInsets: insets)
    }
    
    func imageByBlending(image: UIImage, mode: CGBlendMode = .normal, isOpaque: Bool = false, alpha: CGFloat = 1, position: CGPoint? = nil) -> UIImage? {
        let pos = position ?? CGPoint(x: (size.width - image.size.width) / 2, y: (size.height - image.size.height) / 2)
        UIGraphicsBeginImageContextWithOptions(size, isOpaque, scale)
        draw(at: CGPoint.zero)
        image.draw(at: pos, blendMode: mode, alpha: alpha)
        let blendedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return blendedImage
    }
}
