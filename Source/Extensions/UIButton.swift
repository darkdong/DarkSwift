//
//  UIButton.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/30.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UIButton {
    func layoutContentVertically(spacing: CGFloat = 0) {
        if let imageSize = imageView?.frame.size, let textSize = titleLabel?.frame.size {
            let contentHeight = imageSize.height + textSize.height + spacing
            imageEdgeInsets = UIEdgeInsets(top: 0, left: textSize.width, bottom: contentHeight - imageSize.height, right: 0)
            titleEdgeInsets = UIEdgeInsets(top: contentHeight - textSize.height, left: 0, bottom: 0, right: imageSize.width)
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
