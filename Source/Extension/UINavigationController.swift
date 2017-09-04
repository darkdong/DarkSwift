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
        if shouldReplaceLastViewController {
            popViewController(animated: false)
        }
        let transition = transition ?? transitionToPresent
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
    
    func popToDismiss(transition: CATransition? = nil) {
        let transition = transition ?? transitionToDismiss
        view.layer.add(transition, forKey: nil)
        popViewController(animated: false)
    }
    
    func popToDismissUntilViewController(_ viewController: UIViewController, transition: CATransition? = nil) {
        let transition = transition ?? transitionToDismiss
        view.layer.add(transition, forKey: nil)
        popToViewController(viewController, animated: false)
    }
    
    func popToDismissUntilRootViewController(transition: CATransition? = nil) {
        let transition = transition ?? transitionToDismiss
        view.layer.add(transition, forKey: nil)
        popToRootViewController(animated: false)
    }
    
    private var transitionToPresent: CATransition {
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromTop
        return transition
    }
    
    private var transitionToDismiss: CATransition {
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromBottom
        return transition
    }
}
