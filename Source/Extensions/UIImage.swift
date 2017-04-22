//
//  UIImage.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/18.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit
import ImageIO
import CoreImage

public extension UIImage {
    convenience init?(contentsOfFilename name: String, inDirectory directoryURL: URL? = Bundle.main.resourceURL) {
        if let imageURL = directoryURL?.appendingPathComponent(name) {
            //demo@2x~ipad.png
            //init contentsOfFile will look for image name with proper modifier such as: @2x, @3x, ~ipad, ~iphone, etc
            //system use "png" in case insensitive as default extension, if extension does not exists
            //You must use explicit extension if image is not "png", e.g. "mypic.jpg" and @nx still works like charm
            self.init(contentsOfFile: imageURL.path)
        } else {
            return nil
        }
    }
    
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: image.cgImage!)
    }
    
    convenience init?(pixelsData: NSData, bitmapInfo: CGBitmapInfo, width: Int, height: Int) {
        let numberOfComponents = 4
        let releaseDataCallback: CGDataProviderReleaseDataCallback = { (pixelsDataPointer, _, _) in
            //release underlying data to prevent memory leak
            print("CGDataProvider is deallocated, we can release pixelsData now")
            Unmanaged<NSData>.fromOpaque(UnsafeRawPointer(pixelsDataPointer!)).release()
        }
        // CGDataProvider just "access" underlying data and doesn't retain it
        // Underlying data may be dealloced while this image is using
        // We must retain underlying data until CGDataProvider is released
        let dataProvider = CGDataProvider(dataInfo: Unmanaged.passRetained(pixelsData).toOpaque(), data: pixelsData.bytes, size: width * height * numberOfComponents, releaseData: releaseDataCallback)
        let bitsPerComponent = 8
        
        if let dataProvider = dataProvider, let cgImage = CGImage(width: width, height: height, bitsPerComponent: bitsPerComponent, bitsPerPixel: bitsPerComponent * numberOfComponents, bytesPerRow: width * numberOfComponents, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: bitmapInfo, provider: dataProvider, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent) {
            self.init(cgImage: cgImage, scale: 1, orientation: .up)
        } else {
            return nil
        }
    }
    
    static func standardLutImage(cubeEdgeLength: Int = 16) -> UIImage {
        let len = cubeEdgeLength
        var data = Data(capacity: len * len * len)
        
        for g in 0..<len {
            for b in 0..<len {
                for r in 0..<len {
                    let rValue = UInt8(r * len + r)
                    let gValue = UInt8(g * len + g)
                    let bValue = UInt8(b * len + b)
//                    let pixel = Data(bytes: [rValue, gValue, bValue, 0]) // RGBA big endian
                    let pixel = Data(bytes: [0, bValue, gValue, rValue]) // RGBA little endian
                    data.append(pixel)
                }
            }
        }
        return UIImage(pixelsData: data as NSData, bitmapInfo: .byteOrder32Little, width: len * len, height: len)!
    }
    
    func resizableImage(topInset: CGFloat? = nil, leftInset: CGFloat? = nil) -> UIImage {
        let top: CGFloat
        if let topInset = topInset {
            top = topInset
        } else {
            top = size.height / 2
        }
        let bottom = size.height - top
        
        let left: CGFloat
        if let leftInset = leftInset {
            left = leftInset
        } else {
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
