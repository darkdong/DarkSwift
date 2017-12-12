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
    public var presentationAnimation: (() -> Void) = {}
    public var presentationCompletion: ((Bool) -> Void)?
    
    public var dismissalTransition = Transition()
    public var dismissalAnimation: (() -> Void) = {}
    public var dismissalCompletion: ((Bool) -> Void)?
    
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
            UIView.animate(withDuration: presentationTransition.duration, delay: presentationTransition.delay, usingSpringWithDamping: presentationTransition.dampingRatio, initialSpringVelocity: presentationTransition.velocity, options: presentationTransition.options, animations: {
                self.presentationTransition.animation()
                self.presentationAnimation()
            }, completion: { (finished) in
                self.presentationCompletion?(finished)
            })
            shouldPresent = false
        }
    }
    
    public func dismiss(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: dismissalTransition.duration, delay: dismissalTransition.delay, usingSpringWithDamping: dismissalTransition.dampingRatio, initialSpringVelocity: dismissalTransition.velocity, options: dismissalTransition.options, animations: {
            self.dismissalTransition.animation()
            self.dismissalAnimation()
        }, completion: { (finished) in
            self.dismissalCompletion?(finished)
        })
    }
}
