//
//  UIButton.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/30.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UIButton {
    //titleEdgeInsets, imageEdgeInsets: to move title or image, make value and -value for the two opposite edges
    //contentEdgeInsets: positive value enlarge button, negative value shrink button
    
    func setHorizontalSpacing(_ spacing: CGFloat) {
        titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
    }
    
    func setVerticalSpacing(_ spacing: CGFloat = 0) {
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
    
    private var contentWidth: CGFloat {
        var width: CGFloat = 0
        
        if let imageWidth = imageView?.frame.width {
            width += imageWidth
        }
        if let textWidth = titleLabel?.frame.width {
            width += textWidth
        }
        return width
    }
    
    func contentEdgeInsetsToLeftmost() -> UIEdgeInsets {
        let contentDx = (frame.width - contentWidth) / 2
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: contentDx)
    }
    
    
    func contentEdgeInsetsToRightmost() -> UIEdgeInsets {
        let contentDx = (frame.width - contentWidth) / 2
        return UIEdgeInsets(top: 0, left: contentDx, bottom: 0, right: 0)
    }
}
