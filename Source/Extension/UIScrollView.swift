//
//  UIScrollView.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/7/29.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UIScrollView {
    func scrollToEnd(animated: Bool, scrollDirection: UICollectionViewScrollDirection = .vertical) {
        switch scrollDirection {
        case .vertical:
            let diff = contentSize.height + contentInset.bottom - frame.height
            if (diff > 0) {
                setContentOffset(CGPoint(x: contentOffset.x, y: diff), animated: animated)
            }
        case .horizontal:
            let diff = contentSize.width + contentInset.right - frame.width
            if (diff > 0) {
                setContentOffset(CGPoint(x: diff, y: contentOffset.y), animated: animated)
            }
        }
    }
}
