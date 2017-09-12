//
//  TransitionViewController.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/7/11.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

open class TransitionViewController: UIViewController {
    public enum BackgroundStyle {
        case effect(UIVisualEffect, UIImage?)
        case color(UIColor?)
    }
    
    public struct Transition {
        public var duration: TimeInterval = 0.3
        public var delay: TimeInterval = 0
        public var dampingRatio: CGFloat = 1
        public var velocity: CGFloat = 0
        public var options: UIViewAnimationOptions = []
        public var animation: (() -> Void) = {}
        public var completion: ((Bool) -> Void)?
    }

    public var backgroundStyle = BackgroundStyle.color(UIColor(white: 0, alpha: 0.66))

    public var presentTransition = Transition()
    public var dismissTransition = Transition()

    var shouldPresent = true
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        switch backgroundStyle {
        case let .effect(effect, image):
            let blurView = UIVisualEffectView(effect: effect)
            blurView.frame = view.bounds
            view.insertSubview(blurView, at: 0)
            
            let snapshotView = UIImageView(frame: view.bounds)
            snapshotView.image = image
            view.insertSubview(snapshotView, aboveSubview: blurView)
            
            presentTransition.animation = {
                snapshotView.alpha = 0
            }
            dismissTransition.animation = {
                snapshotView.alpha = 1
            }
        case let .color(color):
            presentTransition.animation = { [unowned self] in
                self.view.backgroundColor = color
            }
            dismissTransition.animation = { [unowned self] in
                self.view.backgroundColor = nil
            }
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if shouldPresent {
            willPresent()
            UIView.animate(withDuration: presentTransition.duration, delay: presentTransition.delay, usingSpringWithDamping: presentTransition.dampingRatio, initialSpringVelocity: presentTransition.velocity, options: presentTransition.options, animations: presentTransition.animation, completion: {
                _ in
                self.didPresent()
            })
            shouldPresent = false
        }
    }
    
    //Subclass should override this method to customize animation for presenting
    open func willPresent() {
    }
    
    //Subclass should override this method to customize animation for dismissing
    open func willDismiss() {
    }

    open func didPresent() {
    }
    
    public func dismiss(completion: (() -> Void)? = nil) {
        willDismiss()
        
        UIView.animate(withDuration: dismissTransition.duration, delay: dismissTransition.delay, usingSpringWithDamping: dismissTransition.dampingRatio, initialSpringVelocity: dismissTransition.velocity, options: dismissTransition.options, animations: dismissTransition.animation, completion: { _ in
            self.dismiss(animated: false, completion: completion)
        })
    }
}
