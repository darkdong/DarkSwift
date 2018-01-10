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
    
    func blend(with image: UIImage, at position: CGPoint? = nil, mode: CGBlendMode = .normal, alpha: CGFloat = 1) -> UIImage? {
        let blendingImage = image.sameImage(scale: scale)!
        let position = position ?? CGPoint(x: (size.width - blendingImage.size.width) / 2, y: (size.height - blendingImage.size.height) / 2)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero)
        blendingImage.draw(at: position, blendMode: mode, alpha: alpha)
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
    
    func scale(to newScale: CGFloat) -> UIImage? {
        let newSize = size * newScale
        return resize(to: newSize)
    }
    
    func resize(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
    
    func rotate(by radius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        let rotatedRect = rect.rotate(radius)
        //Create the bitmap context
        UIGraphicsBeginImageContextWithOptions(rotatedRect.size, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        context.translateBy(x: rotatedRect.width / 2, y: rotatedRect.height / 2)
        //Rotate the image context
        context.rotate(by: radius)
        //Now, draw the rotated/scaled image into the context
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(cgImage!, in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rotatedImage
    }
    
	func horizonalMirror() -> UIImage {
		var flippedOrientation: UIImageOrientation = .up
		
		switch imageOrientation {
		case .up:
			flippedOrientation = .upMirrored
		case .down:
			flippedOrientation = .downMirrored
		case .right:
			flippedOrientation = .leftMirrored
		case .left:
			flippedOrientation = .rightMirrored
		case .upMirrored:
			flippedOrientation = .up
		case .downMirrored:
			flippedOrientation = .down
		case .leftMirrored:
			flippedOrientation = .right
		case .rightMirrored:
			flippedOrientation = .left
		}
		
		return UIImage(cgImage: cgImage!, scale: scale, orientation: flippedOrientation)
	}
    
	func verticalMirror() -> UIImage {
		var flippedOrientation: UIImageOrientation = .up

		switch imageOrientation {
		case .up:
			flippedOrientation = .downMirrored
		case .down:
			flippedOrientation = .upMirrored
		case .right:
			flippedOrientation = .rightMirrored
		case .left:
			flippedOrientation = .leftMirrored
		case .upMirrored:
			flippedOrientation = .down
		case .downMirrored:
			flippedOrientation = .up
		case .leftMirrored:
			flippedOrientation = .left
		case .rightMirrored:
			flippedOrientation = .right
		}
		
		return UIImage(cgImage: cgImage!, scale: scale, orientation: flippedOrientation)
	}
	
    func sameImage(scale: CGFloat? = nil) -> UIImage? {
        let newScale = scale ?? UIScreen.main.scale
        if let cgImage = self.cgImage {
            return UIImage(cgImage: cgImage, scale: newScale, orientation: imageOrientation)
        } else if let ciImage = self.ciImage {
            return UIImage(ciImage: ciImage, scale: newScale, orientation: imageOrientation)
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
        return CIImage(image: self)?.applyingFilter(filter).uiImage(rectForInfinite: rect)?.sameImage(scale: scale)
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
    
	func imageWithInsets(insets: UIEdgeInsets, insetsColor: UIColor = .white, targetSize: CGSize, backgroundImage: UIImage? = nil) -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(targetSize, false, scale)
		let context = UIGraphicsGetCurrentContext()
		let fullRect = CGRect(origin: .zero, size: targetSize)
		context?.setFillColor(insetsColor.cgColor)
		context?.fill(fullRect)
		
		let origin = CGPoint(x: insets.left, y: insets.top)
		let width = targetSize.width - insets.left - insets.right
		let height = targetSize.height - insets.top - insets.bottom
		let size = CGSize(width: width, height: height)
		if let backgroundImage = backgroundImage {
			backgroundImage.draw(in: fullRect)
		}
		self.draw(in: CGRect(origin: origin, size: size))
		let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return imageWithInsets
	}
	
    var desc: String {
        return "size: \(size), scale: \(scale), pixelSize: \(pixelSize) orientation: \(imageOrientation.rawValue)"
    }
}
