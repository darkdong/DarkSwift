//
//  UINavigationController.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/9/4.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UINavigationController {
    func pushToPresent(viewController: UIViewController, shouldReplaceLastViewController: Bool, transition: CATransition? = nil) {
        let trans: CATransition
        if let transition = transition {
            trans = transition
        } else {
            trans = CATransition()
            trans.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            trans.type = kCATransitionMoveIn
            trans.subtype = kCATransitionFromTop
        }
        if shouldReplaceLastViewController {
            popViewController(animated: false)
        }
        view.layer.add(trans, forKey: nil)
        pushViewController(viewController, animated: false)
    }
    
    func popToDismiss(transition: CATransition? = nil) {
        let trans: CATransition
        if let transition = transition {
            trans = transition
        } else {
            trans = CATransition()
            trans.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            trans.type = kCATransitionReveal
            trans.subtype = kCATransitionFromBottom
        }
        view.layer.add(trans, forKey: nil)
        popViewController(animated: false)
    }
}
