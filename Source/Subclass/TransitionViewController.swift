//
//  TransitionViewController.swift
//  Duola
//
//  Created by Dark Dong on 2017/7/11.
//  Copyright © 2017年 Dora Technology. All rights reserved.
//

import UIKit

open class TransitionViewController: UIViewController {
    struct Transition {
        var duration: TimeInterval = 0.3
        var delay: TimeInterval = 0
        var dampingRatio: CGFloat = 1
        var velocity: CGFloat = 0
        var options: UIViewAnimationOptions = []
        var animation: (() -> Void) = {}
        var completion: ((Bool) -> Void)?
    }

    var presentTransition = Transition()
    var dismissTransition = Transition()

    var shouldPresent = true
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        presentTransition.animation = { [unowned self] in
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.66)
            self.view.layoutIfNeeded()
        }
        
        dismissTransition.animation = { [unowned self] in
            self.view.backgroundColor = nil
            self.view.layoutIfNeeded()
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if shouldPresent {
            willPresent()
            UIView.animate(withDuration: presentTransition.duration, delay: presentTransition.delay, usingSpringWithDamping: presentTransition.dampingRatio, initialSpringVelocity: presentTransition.velocity, options: presentTransition.options, animations: presentTransition.animation, completion: {
                [weak self] _ in
                self?.didPresent()
            })
            shouldPresent = false
        }
    }
    
    public func willPresent() {
    }
    
    func willDismiss() {
    }

    func didPresent() {
    }
    
    public func dismiss(completion: (() -> Void)? = nil) {
        willDismiss()
        
        UIView.animate(withDuration: dismissTransition.duration, delay: dismissTransition.delay, usingSpringWithDamping: dismissTransition.dampingRatio, initialSpringVelocity: dismissTransition.velocity, options: dismissTransition.options, animations: dismissTransition.animation, completion: { [weak self] _ in
            self?.dismiss(animated: false, completion: completion)
        })
    }
}
