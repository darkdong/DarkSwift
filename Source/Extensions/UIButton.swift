//
//  UIButton.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/30.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UIButton {
    enum Alignment {
        case horizontalImageText
        case horizontalTextImage
        case verticalImageText
        case verticalTextImage
    }
    //When you want spacing between an image and a title, without causing either to be crushed, you need to set four different insets, two on each of the image and title. That's because you don't want to change the sizes of those elements' frames, but just their positions.
    // To move image/title on certain direction, set imageEdgeInsets/titleEdgeInsets on two same directional edges with +value and -value respectively.
    // To expand or shrink content on certain direction, set contentEdgeInsets on two same directional edges with +value or -value respectively.
    
    private func moveBy(imageOffset: CGPoint, titleOffset: CGPoint, contentOffset: CGPoint) {
        func makeOffset(_ offset: CGPoint, on insets: inout UIEdgeInsets, isContent: Bool) {
            insets += UIEdgeInsets(top: offset.y, left: offset.x, bottom: isContent ? offset.y : -offset.y, right: isContent ? offset.x : -offset.x)
        }
        makeOffset(imageOffset, on: &imageEdgeInsets, isContent: false)
        makeOffset(titleOffset, on: &titleEdgeInsets, isContent: false)
        makeOffset(contentOffset, on: &contentEdgeInsets, isContent: true)
    }
    
    // spacing is nil means max
    func align(_ alignment: Alignment, spacing: CGFloat? = 0) {
        if let imageSize = imageView?.frame.size, let textSize = titleLabel?.frame.size {
            func xspacing() -> CGFloat {
                if let spacing = spacing {
                    return spacing / 2
                } else {
                    return (frame.width - imageSize.width - textSize.width) / 2
                }
            }
            func yspacing() -> CGFloat {
                if let spacing = spacing {
                    return spacing / 2
                } else {
                    return (frame.height - imageSize.height - textSize.height) / 2
                }
            }
            switch alignment {
            case .horizontalImageText:
                // 1. calculate horizontal spacing
                let x = xspacing()
                
                // 2. take into acount spacing, image will be more left, title will be more right, expand content on x
                moveBy(imageOffset: CGPoint(x: -x, y: 0), titleOffset: CGPoint(x: x, y: 0), contentOffset: CGPoint(x: x, y: 0))
            case .horizontalTextImage:
                // 1. swap image and title position, keep content
                let idx = textSize.width
                let tdx = -imageSize.width

                // 2. calculate horizontal spacing
                let x = xspacing()

                // 3. take into acount spacing, image will be more right, title will be more left, expand content on x
                moveBy(imageOffset: CGPoint(x: idx + x, y: 0), titleOffset: CGPoint(x: tdx - x, y: 0), contentOffset: CGPoint(x: x, y: 0))
            case .verticalImageText:
                // 1. center image and title (overlapped), shrink content on x
                let idx = textSize.width / 2
                let tdx = -imageSize.width / 2
                let cdx = -(idx-tdx) / 2
                
                // 2. make image up and title down to keep spacing = 0, expand content on y
                let idy = -textSize.height / 2
                let tdy = imageSize.height / 2
                let cdy = min(imageSize.height, textSize.height) / 2
                
                // 3. calculate vertical spacing
                let y = yspacing()
                
                // 4. take into acount spacing, image will be more up, title will be more down, expand content on y
                moveBy(imageOffset: CGPoint(x: idx, y: idy - y), titleOffset: CGPoint(x: tdx, y: tdy + y), contentOffset: CGPoint(x: cdx, y: cdy + y))
            case .verticalTextImage:
                // 1. center image and title (overlapped), shrink content on x
                let idx = textSize.width / 2
                let tdx = -imageSize.width / 2
                let cdx = -(idx-tdx) / 2
                
                // 2. make image down and title up to keep spacing = 0, expand content on y
                let idy = textSize.height / 2
                let tdy = -imageSize.height / 2
                let cdy = min(imageSize.height, textSize.height) / 2
                
                // 3. calculate vertical spacing
                let y = yspacing()
                
                // 4. take into acount spacing, image will be more down, title will be more up, expand content on y
                moveBy(imageOffset: CGPoint(x: idx, y: idy + y), titleOffset: CGPoint(x: tdx, y: tdy - y), contentOffset: CGPoint(x: cdx, y: cdy + y))
            }
        }
    }
    
    func setSelectedImage(tintedColor: UIColor = UIColor(white: 0, alpha: 0.3)) {
        if let image = backgroundImage(for: [.normal]) {
            setBackgroundImage(image.tinted(by: tintedColor)?.resizableImage(withCapInsets: image.capInsets), for: .highlighted)
        }
        
        if let image = backgroundImage(for: [.selected]) {
            setBackgroundImage(image.tinted(by: tintedColor)?.resizableImage(withCapInsets: image.capInsets), for: [.selected, .highlighted])
        }
        
        if let image = image(for: [.normal]) {
            setImage(image.tinted(by: tintedColor), for: .highlighted)
        }
        
        if let image = image(for: [.selected]) {
            setImage(image.tinted(by: tintedColor), for: [.selected, .highlighted])
        }
    }
}
