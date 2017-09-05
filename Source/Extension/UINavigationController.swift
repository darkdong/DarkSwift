//
//  UINavigationController.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/9/4.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UINavigationController {
    func pushLikePresentation(viewController: UIViewController, onViewController targetViewController: UIViewController) {
        popToViewController(targetViewController, animated: false)
        view.layer.add(transitionToPresent, forKey: nil)
        pushViewController(viewController, animated: false)
    }
    
    func pushLikePresentation(viewController: UIViewController, onViewControllerAtIndex index: Int = -1) {
        pushLikePresentation(viewController: viewController, onViewController: viewControllerAtIndex(index))
    }
    
    func popLikeDismissal(toViewController vc: UIViewController) {
        view.layer.add(transitionToDismiss, forKey: nil)
        popToViewController(vc, animated: false)
    }

    func popLikeDismissal(toViewControllerAtIndex index: Int = -2) {
        popLikeDismissal(toViewController: viewControllerAtIndex(index))
    }

    private func viewControllerAtIndex(_ index: Int) -> UIViewController {
        if index < 0 {
            // -1 is the last, -2 is the prev to last and so on
            return viewControllers[viewControllers.endIndex + index]
        } else {
            return viewControllers[index]
        }
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
