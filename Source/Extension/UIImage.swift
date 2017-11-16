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
            //You must use explicit extension if image is not "png", e.g. "mypic.jpg" while @nx still works like charm
            self.init(contentsOfFile: imageURL.path)
        } else {
            return nil
        }
    }
    
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: image.cgImage!)
    }
    
    convenience init?(data: Data, width: Int, height: Int, bitmapInfo: CGBitmapInfo = CGBitmapInfo()) {
        let numberOfComponents = 4
        let releaseDataCallback: CGDataProviderReleaseDataCallback = { (pixelsDataPointer, _, _) in
            //release underlying data to prevent memory leak
//            print("CGDataProvider is deallocated, we can release pixelsData now")
            Unmanaged<NSData>.fromOpaque(UnsafeRawPointer(pixelsDataPointer!)).release()
        }
        // CGDataProvider just "access" underlying data and doesn't retain it
        // Underlying data may be dealloced while this image is using
        // We must retain underlying data until CGDataProvider is released
        let dataProvider = CGDataProvider(dataInfo: Unmanaged.passRetained(data as NSData).toOpaque(), data: (data as NSData).bytes, size: width * height * numberOfComponents, releaseData: releaseDataCallback)
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
        color.setFill()
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
        if let cgImage = cgImage?.cropping(to: rect * scale) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        } else {
            return nil
        }
    }
    
    func cropToSquare() -> UIImage? {
        let squareSideLength = min(size.width, size.height)
        let squareSize = CGSize(width: squareSideLength, height: squareSideLength)
        let rect = size.scaledRectForFillingSize(squareSize)
        return crop(to: rect)
    }
    
    func resize(to newSize: CGSize, scale: CGFloat? = nil) -> UIImage? {
        let newScale = scale ?? self.scale
        UIGraphicsBeginImageContextWithOptions(newSize, false, newScale)
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    func rotate(by radius: CGFloat, scale: CGFloat? = nil) -> UIImage? {
        let newScale = scale ?? self.scale
        //Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        rotatedViewBox.transform = CGAffineTransform(rotationAngle: radius)
        let rotatedSize = rotatedViewBox.frame.size
        //Create the bitmap context
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, newScale)
        let context = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        //Rotate the image context
        context.rotate(by: radius)
        //Now, draw the rotated/scaled image into the context
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(cgImage!, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rotatedImage
    }
    
    func sameImageWithScale(_ scale: CGFloat) -> UIImage? {
        if let cgImage = self.cgImage {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        } else if let ciImage = self.ciImage {
            return UIImage(ciImage: ciImage, scale: scale, orientation: imageOrientation)
        } else {
            return nil
        }
    }
    
    var data: Data? {
        return cgImage?.dataProvider?.data as Data?
    }
    
    var pixelSize: CGSize {
        return size * scale
    }
    
    func filter(by filter: ImageFilter?) -> UIImage? {
        let rect = CGRect(origin: CGPoint.zero, size: size * scale)
        return CIImage(image: self)?.applyingFilter(filter).uiImage(rectForInfinite: rect)?.sameImageWithScale(scale)
    }
    
    func imageForFillingSize(_ targetSize: CGSize) -> UIImage? {
        let scaledRect = size.scaledRectForFillingSize(targetSize)
        let scaledImage = resize(to: scaledRect.size)
        return scaledImage?.crop(to: scaledRect)
    }
    
    func imageForFittingSize(_ targetSize: CGSize, paddingColor: UIColor? = nil) -> UIImage? {
        if let color = paddingColor {
            UIGraphicsBeginImageContextWithOptions(targetSize, true, scale)
            let context = UIGraphicsGetCurrentContext()!
            context.setFillColor(color.cgColor)
            context.fill(CGRect(origin: CGPoint.zero, size: targetSize))
        } else {
            UIGraphicsBeginImageContextWithOptions(targetSize, false, scale)
        }
        let scaledRect = size.scaledRectForFittingSize(targetSize)
        let scaledImage = resize(to: scaledRect.size)
        scaledImage?.draw(at: scaledRect.origin)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    var desc: String {
        return "size: \(size), scale: \(scale), pixelSize: \(pixelSize) orientation: \(imageOrientation.rawValue)"
    }
}
