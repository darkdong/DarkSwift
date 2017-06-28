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
    //titleEdgeInsets, imageEdgeInsets: to move title or image, make value and -value for the two opposite edges
    //contentEdgeInsets: positive value enlarge button, negative value shrink button
    
    private func move(imageDx: CGFloat, titleDx: CGFloat, contentDx: CGFloat) {
        imageEdgeInsets += UIEdgeInsets(top: 0, left: imageDx, bottom: 0, right: -imageDx)
        titleEdgeInsets += UIEdgeInsets(top: 0, left: titleDx, bottom: 0, right: -titleDx)
        contentEdgeInsets += UIEdgeInsets(top: 0, left: contentDx, bottom: 0, right: contentDx)
    }
    
    private func move(imageDy: CGFloat, titleDy: CGFloat, contentDy: CGFloat) {
        imageEdgeInsets += UIEdgeInsets(top: imageDy, left: 0, bottom: -imageDy, right: 0)
        titleEdgeInsets += UIEdgeInsets(top: titleDy, left: 0, bottom: -titleDy, right: 0)
        contentEdgeInsets += UIEdgeInsets(top: contentDy, left: 0, bottom: contentDy, right: 0)
    }

    func align(_ alignment: Alignment, spacing: CGFloat? = 0) {
        if let imageSize = imageView?.frame.size, let textSize = titleLabel?.frame.size {
            func offsetX() -> CGFloat {
                if let spacing = spacing {
                    return spacing / 2
                } else {
                    return (frame.width - imageSize.width - textSize.width) / 2
                }
            }
            func offsetY() -> CGFloat {
                if let spacing = spacing {
                    return spacing / 2
                } else {
                    return (frame.height - imageSize.height - textSize.height) / 2
                }
            }
            switch alignment {
            case .horizontalImageText:
                let dx = offsetX()
                move(imageDx: -dx, titleDx: dx, contentDx: dx)
            case .horizontalTextImage:
                let dx = offsetX()
                //swap image and title
                move(imageDx: textSize.width, titleDx: -imageSize.width, contentDx: 0)
                //almost same to horizontalImageText, but in opposite direction
                move(imageDx: dx, titleDx: -dx, contentDx: dx)
            case .verticalImageText:
                //move by x to center image and title
                let contentDx = (textSize.width/2 + imageSize.width/2) / 2
                move(imageDx: textSize.width/2, titleDx: -imageSize.width/2, contentDx: -contentDx)
                //move by y to make spacing = 0
                let contentDy = min(imageSize.height, textSize.height) / 2
                move(imageDy: -textSize.height/2, titleDy: imageSize.height/2, contentDy: contentDy)
                //move by y to spacing
                let dy = offsetY()
                move(imageDy: -dy, titleDy: dy, contentDy: dy)
            case .verticalTextImage:
                //move by x to center image and title
                let contentDx = (textSize.width/2 + imageSize.width/2) / 2
                move(imageDx: textSize.width/2, titleDx: -imageSize.width/2, contentDx: -contentDx)
                //move by y to make spacing = 0
                let contentDy = min(imageSize.height, textSize.height) / 2
                move(imageDy: textSize.height/2, titleDy: -imageSize.height/2, contentDy: contentDy)
                //move by y to spacing
                let dy = offsetY()
                move(imageDy: dy, titleDy: -dy, contentDy: dy)
            }
            
        }
    }
    
    func setContentHorizontally(spacing: CGFloat) {
        titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
    }
    
    func setContentVertically(spacing: CGFloat = 0) {
        if let imageSize = imageView?.frame.size, let textSize = titleLabel?.frame.size {
            let imageDx = textSize.width / 2
            let imageDy = (textSize.height + spacing) / 2
            imageEdgeInsets = UIEdgeInsets(top: -imageDy, left: imageDx, bottom: imageDy, right: -imageDx)
            
            let titleDx = imageSize.width / 2
            let titleDy = (imageSize.height + spacing) / 2
            titleEdgeInsets = UIEdgeInsets(top: titleDy, left: -titleDx, bottom: -titleDy, right: titleDx)

            let contentDx = (imageSize.width + textSize.width - max(imageSize.width, textSize.width)) / 2
            let contentDy = (imageSize.height + textSize.height + spacing - max(imageSize.height, textSize.height)) / 2
            contentEdgeInsets = UIEdgeInsets(top: contentDy, left: -contentDx, bottom: contentDy, right: -contentDx)
        }
    }
    
    func setContentVerticalEnds() {
        if let imageSize = imageView?.frame.size, let textSize = titleLabel?.frame.size {
            contentHorizontalAlignment = .left
            contentVerticalAlignment = .top
            imageEdgeInsets = UIEdgeInsetsMake(0, frame.width/2 - imageSize.width/2, 0, 0)
            let dx = frame.width/2 - textSize.width/2 - imageSize.width
            titleEdgeInsets = UIEdgeInsetsMake(frame.height - textSize.height, dx, 0, -dx)
        }
    }
    
//    func setContentLeftmost() {
//        contentEdgeInsets = contentEdgeInsetsForLeftmost()
//    }
//    
//    func setContentRightmost() {
//        contentEdgeInsets = contentEdgeInsetsForRightmost()
//    }
//    
//    private var contentWidth: CGFloat {
//        var width: CGFloat = 0
//        
//        if let imageWidth = imageView?.frame.width {
//            width += imageWidth
//        }
//        if let textWidth = titleLabel?.frame.width {
//            width += textWidth
//        }
//        return width
//    }
//    
//    func contentEdgeInsetsForLeftmost() -> UIEdgeInsets {
//        let contentDx = frame.width - contentWidth
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: contentDx)
//    }
//    
//    func contentEdgeInsetsForRightmost() -> UIEdgeInsets {
//        let contentDx = frame.width - contentWidth
//        return UIEdgeInsets(top: 0, left: contentDx, bottom: 0, right: 0)
//    }
}
