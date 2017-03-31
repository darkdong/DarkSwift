//
//  UIButton.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/30.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UIButton {
    func layoutContentVertically(_ spacing: CGFloat = 0) {
        if let imageSize = imageView?.frame.size, let textSize = titleLabel?.frame.size {
            let contentHeight = imageSize.height + textSize.height + spacing
            imageEdgeInsets = UIEdgeInsetsMake(0, textSize.width, contentHeight - imageSize.height, 0)
            titleEdgeInsets = UIEdgeInsetsMake(contentHeight - textSize.height, 0, 0, imageSize.width)
        }
    }
    
    func layoutContentLeftmost() {
        var contentWidth: CGFloat = 0
        
        if let imageWidth = imageView?.frame.width {
            contentWidth += imageWidth + imageEdgeInsets.left + imageEdgeInsets.right
        }
        if let textWidth = titleLabel?.frame.width {
            contentWidth += textWidth + titleEdgeInsets.left + titleEdgeInsets.right
        }
        //TODO: if there is insets, frame.size.width - contentWidth is not the leftmost exactly, need to revise in future
        contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, frame.width - contentWidth)
    }
    
    func layoutContentRightmost() {
        var contentWidth: CGFloat = 0
        
        if let imageWidth = imageView?.frame.width {
            contentWidth += imageWidth + imageEdgeInsets.left + imageEdgeInsets.right
        }
        if let textWidth = titleLabel?.frame.width {
            contentWidth += textWidth + titleEdgeInsets.left + titleEdgeInsets.right
        }
        //TODO: if there is insets, frame.size.width - contentWidth is not the leftmost exactly, need to revise in future
        contentEdgeInsets = UIEdgeInsetsMake(0, frame.width - contentWidth, 0, 0)
    }
}
