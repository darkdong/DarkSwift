//
//  UIScrollView.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/7/29.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UIScrollView {
	func scrollToEnd(animated: Bool, scrollDirection: UICollectionView.ScrollDirection = .vertical) {
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
		@unknown default:
			fatalError()
		}
    }
    
    func visibleContentImage(extraScale: CGFloat = 1) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, UIScreen.main.scale * extraScale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: -contentOffset.x, y: -contentOffset.y)
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    var contentOffsetForCentering: CGPoint {
        return CGPoint(x: (contentSize.width - frame.width) / 2, y: (contentSize.height - frame.height) / 2)
    }
}

public extension UITableView {
    func clearsSelection(animated: Bool) {
        if let indexPaths = indexPathsForSelectedRows {
            for indexPath in indexPaths {
                deselectRow(at: indexPath, animated: animated)
            }
        }
    }
}

public extension UICollectionView {
    func clearsSelection(animated: Bool) {
        if let indexPaths = indexPathsForSelectedItems {
            for indexPath in indexPaths {
                deselectItem(at: indexPath, animated: animated)
            }
        }
    }
}
