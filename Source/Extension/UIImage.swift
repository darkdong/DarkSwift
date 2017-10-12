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
    convenience init?(contentsOfFilename name: String, bundle: URL? = Bundle.main.resourceURL) {
        if let imageURL = bundle?.appendingPathComponent(name) {
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
    
    convenience init?(ciImage: CIImage, ciContext: CIContext? = nil) {
        let context = ciContext ?? CIContext()
        if let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            self.init(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
        } else {
            return nil
        }
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
    
    func tint(by color: UIColor = UIColor(white: 0, alpha: 0.3)) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        draw(in: rect)
        color.set()
        UIRectFillUsingBlendMode(rect, .sourceAtop)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
    }
    
    func blend(by image: UIImage, mode: CGBlendMode = .normal, isOpaque: Bool = false, alpha: CGFloat = 1, position: CGPoint? = nil) -> UIImage? {
        //FIXME: both self and image should use size with scale 1
        let pos = position ?? CGPoint(x: (size.width - image.size.width) / 2, y: (size.height - image.size.height) / 2)
        UIGraphicsBeginImageContextWithOptions(size, isOpaque, scale)
        draw(at: CGPoint.zero)
        image.draw(at: pos, blendMode: mode, alpha: alpha)
        let blendedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return blendedImage
    }
    
    func crop(to rect: CGRect) -> UIImage? {
        let t = CGAffineTransform(scaleX: scale, y: scale)
        let pixelRect = rect.applying(t)
        if let cgImage = cgImage?.cropping(to: pixelRect) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        } else {
            return nil
        }
    }
    
    func resize(to newSize: CGSize, quality: CGInterpolationQuality = .default) -> UIImage {
        var drawTransposed = false
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            drawTransposed = true
        default:
            break
        }
        let transform = transformForSize(newSize)
        return resizedImage(size: newSize, transform: transform, drawTransposed: drawTransposed, quality: quality)
    }
    
    func rotate(by radius: CGFloat) -> UIImage {
        //Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        rotatedViewBox.transform = CGAffineTransform(rotationAngle: radius)
        let rotatedSize = rotatedViewBox.frame.size
        //Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        //Rotate the image context
        bitmap.rotate(by: radius)
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(cgImage!, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    //MARK:- private
    private func transformForSize(_ size: CGSize) -> CGAffineTransform {
        var transform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, // EXIF = 3
        .downMirrored: // EXIF = 4
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: .pi)
        case .left, // EXIF = 6
        .leftMirrored: // EXIF = 5
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
        case .right, // EXIF = 8
        .rightMirrored: // EXIF = 7
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: .pi / -2)
        default:
            break
        }
        
        switch imageOrientation {
        case .upMirrored, // EXIF = 2
        .downMirrored: // EXIF = 4
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, // EXIF = 5
        .rightMirrored: // EXIF = 7
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        return transform
    }
    
    private func resizedImage(size: CGSize, transform: CGAffineTransform, drawTransposed: Bool, quality: CGInterpolationQuality = CGInterpolationQuality.default) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width * scale, height: size.height * scale).integral
        let transposedRect = CGRect(x: 0, y: 0, width: rect.height, height: rect.width)
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo().rawValue | CGImageAlphaInfo.premultipliedLast.rawValue)
        let bitmap: CGContext = CGContext(data: nil, width: Int(rect.width), height: Int(rect.height), bitsPerComponent: 8, bytesPerRow: Int(rect.width) * 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: bitmapInfo.rawValue)!
        
        bitmap.concatenate(transform)
        
        // Set the quality level to use when rescaling
        bitmap.interpolationQuality = quality
        
        // Draw into the context; this scales the image
        if let cgImage = cgImage {
            bitmap.draw(cgImage, in: drawTransposed ? transposedRect : rect)
        } else if let ciImage = ciImage {
            let ciContext = CIContext(options: nil)
            let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent)
            bitmap.draw(cgImage!, in: drawTransposed ? transposedRect : rect)
        }
        
        // Get the resized image from the context and a UIImage
        let resizedCGImage = bitmap.makeImage()
        
        return UIImage(cgImage: resizedCGImage!, scale: scale, orientation: .up)
    }
}
