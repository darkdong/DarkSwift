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
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: image.cgImage!)
    }
    
    //NOTE: rawData may be dealloced in ARC, set shouldCopyData = true to prevent it
    //If you assure that rawData won't be dealloced in image's life, just set shouldCopyData = false to prevent copy
    convenience init?(rawData: NSData, bitmapInfo: CGBitmapInfo, shouldCopyData: Bool, width: Int, height: Int) {
        let numberOfComponents = 4
        let dataProvider: CGDataProvider?
        
        if shouldCopyData {
            let newBuf = UnsafeMutablePointer<UInt8>.allocate(capacity: rawData.length)
            (rawData as Data).copyBytes(to: newBuf, count: rawData.length)
            let releaseDataCallback: CGDataProviderReleaseDataCallback = { (dataInfo, _, size) in
                print("dataProvider is deallocated, we can deallocate memory used by dataProvider safely")
                if let buf = dataInfo?.bindMemory(to: UInt8.self, capacity: size) {
                    print("deallocate memory \(buf) size \(size)")
                    buf.deallocate(capacity: size)
                }
            }
            dataProvider = CGDataProvider(dataInfo: newBuf, data: newBuf, size: width * height * numberOfComponents, releaseData: releaseDataCallback)
        } else {
            let releaseDataCallback: CGDataProviderReleaseDataCallback = { (_, _, _) in
                print("dataProvider is deallocated, no memory needs to free")
            }
            dataProvider = CGDataProvider(dataInfo: nil, data: (rawData as NSData).bytes, size: width * height * numberOfComponents, releaseData: releaseDataCallback)
        }
        
        let bitsPerComponent = 8
        
        if let dataProvider = dataProvider, let cgImage = CGImage(width: width, height: height, bitsPerComponent: bitsPerComponent, bitsPerPixel: bitsPerComponent * numberOfComponents, bytesPerRow: width * numberOfComponents, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: bitmapInfo, provider: dataProvider, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent) {
            self.init(cgImage: cgImage, scale: 1, orientation: .up)
        } else {
            return nil
        }
    }

    
//    convenience init?(rawData: Data, bitmapInfo: CGBitmapInfo, shouldCopyData: Bool, width: Int, height: Int) {
//        let numberOfComponents = 4
//        let dataProvider: CGDataProvider?
//        
//        if shouldCopyData {
//            //dataProvider depend on rawData, and rawData may be deallocated when the image is being used
//            //so we must allocate a new memory for dataProvider and deallocate it when dataProvider is deallocated
//            
//            let newBuf = UnsafeMutablePointer<UInt8>.allocate(capacity: rawData.count)
//            rawData.copyBytes(to: newBuf, count: rawData.count)
//            let releaseDataCallback: CGDataProviderReleaseDataCallback = { (dataInfo, _, size) in
//                print("dataProvider is deallocated, we can deallocate memory used by dataProvider safely")
//                if let buf = dataInfo?.bindMemory(to: UInt8.self, capacity: size) {
//                    print("deallocate memory \(buf) size \(size)")
//                    buf.deallocate(capacity: size)
//                }
//            }
//            dataProvider = CGDataProvider(dataInfo: newBuf, data: newBuf, size: width * height * numberOfComponents, releaseData: releaseDataCallback)
//        } else {
//            //            let _: NSData = rawData as NSData
//            //            dataProvider = rawData.withUnsafeBytes({ (pointer: UnsafePointer<UInt8>) -> CGDataProvider? in
//            //                return CGDataProvider(dataInfo: nil, data: pointer, size: width * height * numberOfComponents, releaseData: {_,_,_ in})
//            //            })
//            let releaseDataCallback: CGDataProviderReleaseDataCallback = { (_, _, _) in
//                print("dataProvider is deallocated, we can deallocate memory used by dataProvider safely")
//            }
//            dataProvider = CGDataProvider(dataInfo: nil, data: (rawData as NSData).bytes, size: width * height * numberOfComponents, releaseData: releaseDataCallback)
//        }
//        
//        let bitsPerComponent = 8
//        
//        if let dataProvider = dataProvider, let cgImage = CGImage(width: width, height: height, bitsPerComponent: bitsPerComponent, bitsPerPixel: bitsPerComponent * numberOfComponents, bytesPerRow: width * numberOfComponents, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: bitmapInfo, provider: dataProvider, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent) {
//            self.init(cgImage: cgImage, scale: 1, orientation: .up)
//        } else {
//            return nil
//        }
//    }
    
//    convenience init?(rawData: Data, bitmapInfo: CGBitmapInfo, width: Int, height: Int) {
//        //dataProvider depend on rawData, and rawData may be deallocated when the image is being used
//        //so we must allocate a new memory for dataProvider and deallocate it when dataProvider is deallocated
//        let newBuf = UnsafeMutablePointer<UInt8>.allocate(capacity: rawData.count)
//        rawData.copyBytes(to: newBuf, count: rawData.count)
//        let releaseDataCallback: CGDataProviderReleaseDataCallback = { (dataInfo, _, size) in
//            print("dataProvider is deallocated, we can deallocate memory used by dataProvider safely")
//            if let buf = dataInfo?.bindMemory(to: UInt8.self, capacity: size) {
//                print("deallocate memory \(buf) size \(size)")
//                buf.deallocate(capacity: size)
//            }
//        }
//        let numberOfComponents = 4
//        
//        let dataProvider = CGDataProvider(dataInfo: newBuf, data: newBuf, size: width * height * numberOfComponents, releaseData: releaseDataCallback)
//        
//        let bitsPerComponent = 8
//        
//        if let dataProvider = dataProvider, let cgImage = CGImage(width: width, height: height, bitsPerComponent: bitsPerComponent, bitsPerPixel: bitsPerComponent * numberOfComponents, bytesPerRow: width * numberOfComponents, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: bitmapInfo, provider: dataProvider, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent) {
//            self.init(cgImage: cgImage, scale: 1, orientation: .up)
//        } else {
//            return nil
//        }
//    }
    
//    convenience init?(rawNSData: NSData, bitmapInfo: CGBitmapInfo, width: Int, height: Int) {
//        let rawData = rawNSData as Data
//        let newBuf = UnsafeMutablePointer<UInt8>.allocate(capacity: rawData.count)
//        rawData.copyBytes(to: newBuf, count: rawData.count)
//        
//        let numberOfComponents = 4
//        let releaseDataCallback: CGDataProviderReleaseDataCallback = { (dataInfo, _, size) in
//            print("dataProvider is deallocated, we can deallocate memory used by dataProvider safely")
//            if let buf = dataInfo?.bindMemory(to: UInt8.self, capacity: size) {
//                print("deallocate memory \(buf) size \(size)")
//                buf.deallocate(capacity: size)
//            }
//        }
//        let dataProvider = CGDataProvider(dataInfo: newBuf, data: newBuf, size: width * height * numberOfComponents, releaseData: releaseDataCallback)
//        
//        let bitsPerComponent = 8
//        
//        if let dataProvider = dataProvider, let cgImage = CGImage(width: width, height: height, bitsPerComponent: bitsPerComponent, bitsPerPixel: bitsPerComponent * numberOfComponents, bytesPerRow: width * numberOfComponents, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: bitmapInfo, provider: dataProvider, decode: nil, shouldInterpolate: true, intent: CGColorRenderingIntent.defaultIntent) {
//            self.init(cgImage: cgImage, scale: 1, orientation: .up)
//        } else {
//            return nil
//        }
//    }
    
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
