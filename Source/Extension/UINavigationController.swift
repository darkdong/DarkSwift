//
//  UINavigationController.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/9/4.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UINavigationController {
    func pushViewController(_ viewController: UIViewController, onViewController targetViewController: UIViewController, by transition: CATransition? = nil) {
        popToViewController(targetViewController, animated: false)
        let transition = transition ?? transitionToPresent
        view.layer.add(transition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
    
    func pushViewController(_ viewController: UIViewController, onViewControllerAtIndex index: Int = -1, by transition: CATransition? = nil) {
        pushViewController(viewController, onViewController: viewControllerAtIndex(index), by: transition)
    }
    
    func popToViewController(_ viewController: UIViewController, by transition: CATransition? = nil) {
        let transition = transition ?? transitionToDismiss
        view.layer.add(transition, forKey: nil)
        popToViewController(viewController, animated: false)
    }

    func popToViewController(atIndex index: Int = -2, by transition: CATransition? = nil) {
        popToViewController(viewControllerAtIndex(index), by: transition)
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
