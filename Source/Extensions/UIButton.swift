//
//  UIButton.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/30.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UIButton {
    func setImageTitleSpacing(_ spacing: CGFloat) {
        titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
    }
    
    func layoutContentVertically(spacing: CGFloat = 0) {
        if let imageSize = imageView?.frame.size, let textSize = titleLabel?.frame.size {
            let contentHeight = imageSize.height + textSize.height + spacing
            
            let imageDx: CGFloat = textSize.width / 2
            imageEdgeInsets = UIEdgeInsets(top: 0, left: imageDx, bottom: contentHeight - imageSize.height, right: -imageDx)
            
            let titleDx: CGFloat = imageSize.width / 2
            titleEdgeInsets = UIEdgeInsets(top: contentHeight - textSize.height, left: -titleDx, bottom: 0, right: titleDx)

            let dw = (imageSize.width + textSize.width - max(imageSize.width, textSize.width)) / 2
            let dh = (imageSize.height + textSize.height - max(imageSize.height, textSize.height)) / 2
            contentEdgeInsets = UIEdgeInsets(top: dh, left: -dw, bottom: dh, right: -dw)
        }
    }
    
    func layoutContentLeftmost(leading: CGFloat = 0) {
        var contentWidth: CGFloat = 0
        
        if let imageWidth = imageView?.frame.width {
            contentWidth += imageWidth + imageEdgeInsets.left + imageEdgeInsets.right
        }
        if let textWidth = titleLabel?.frame.width {
            contentWidth += textWidth + titleEdgeInsets.left + titleEdgeInsets.right
        }
        //TODO: if there is insets, frame.size.width - contentWidth is not the leftmost exactly, need to revise in future
        contentEdgeInsets = UIEdgeInsets(top: 0, left: leading, bottom: 0, right: frame.width - contentWidth - leading)
    }
    
    func layoutContentRightmost(trailing: CGFloat = 0) {
        var contentWidth: CGFloat = 0
        
        if let imageWidth = imageView?.frame.width {
            contentWidth += imageWidth + imageEdgeInsets.left + imageEdgeInsets.right
        }
        if let textWidth = titleLabel?.frame.width {
            contentWidth += textWidth + titleEdgeInsets.left + titleEdgeInsets.right
        }
        //TODO: if there is insets, frame.size.width - contentWidth is not the leftmost exactly, need to revise in future
        contentEdgeInsets = UIEdgeInsets(top: 0, left: frame.width - contentWidth - trailing, bottom: 0, right: trailing)
    }
}
