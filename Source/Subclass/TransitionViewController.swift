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
        case color(UIColor)
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
    public var presentationTransition = Transition()
    public var dismissalTransition = Transition()
    
    private var shouldPresent = true
    
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
            
            presentationTransition.animation = {
                snapshotView.alpha = 0
            }
            dismissalTransition.animation = {
                snapshotView.alpha = 1
            }
        case let .color(color):
            view.backgroundColor = nil
            presentationTransition.animation = { [unowned self] in
                self.view.backgroundColor = color
            }
            dismissalTransition.animation = { [unowned self] in
                self.view.backgroundColor = nil
            }
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if shouldPresent {
            startPresenting()
            UIView.animate(withDuration: presentationTransition.duration, delay: presentationTransition.delay, usingSpringWithDamping: presentationTransition.dampingRatio, initialSpringVelocity: presentationTransition.velocity, options: presentationTransition.options, animations: presentationTransition.animation, completion: presentationTransition.completion)
            shouldPresent = false
        }
    }
    
    //Subclass should override this method to customize animation for presenting
    open func startPresenting() {
    }
    
    //Subclass should override this method to customize animation for dismissing
    open func startDismissing() {
    }
    
    override open func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        if flag {
            startDismissing()
            UIView.animate(withDuration: dismissalTransition.duration, delay: dismissalTransition.delay, usingSpringWithDamping: dismissalTransition.dampingRatio, initialSpringVelocity: dismissalTransition.velocity, options: dismissalTransition.options, animations: dismissalTransition.animation, completion: { finished in
                self.dismissalTransition.completion?(finished)
                super.dismiss(animated: false, completion: completion)
            })
        } else {
            super.dismiss(animated: false, completion: completion)
        }
    }
}
