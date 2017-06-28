//
//  CALayer.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/6/27.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

public extension CALayer {
    func renderedImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, isOpaque, 0)
        render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func setMask(by path: CGPath) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = path
        mask = maskLayer
    }
    
    private func circularPath(center: CGPoint, radius: CGFloat) -> CGPath {
        return UIBezierPath(ovalIn: CGRect(origin: center, size: CGSize.zero).insetBy(dx: -radius, dy: -radius)).cgPath
    }
    
    private func animate(center: CGPoint, fromRadius: CGFloat, toRadius: CGFloat, animationDuration: TimeInterval, animationKey: String? = nil, animationDelegate: CAAnimationDelegate? = nil) {
        setMask(by: circularPath(center: center, radius: toRadius))
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = animationDuration
        animation.fromValue = circularPath(center: center, radius: fromRadius)
        animation.delegate = animationDelegate
        mask?.add(animation, forKey: animationKey)
    }
    
    // reveal content from center
    func reveal(fromRadius: CGFloat = 0, toRadius: CGFloat? = nil, animationDuration: TimeInterval, animationKey: String? = nil, animationDelegate: CAAnimationDelegate? = nil) {
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let toRadius = toRadius ?? sqrt((center.x * center.x) + (center.y * center.y))
        
        animate(center: center, fromRadius: fromRadius, toRadius: toRadius, animationDuration: animationDuration, animationKey: animationKey, animationDelegate: animationDelegate)
    }
    
    // unreveal content to center
    func unreveal(fromRadius: CGFloat? = nil, toRadius: CGFloat = 0, animationDuration: TimeInterval, animationKey: String? = nil, animationDelegate: CAAnimationDelegate? = nil) {
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let fromRadius = fromRadius ?? sqrt((center.x * center.x) + (center.y * center.y))
        
        animate(center: center, fromRadius: fromRadius, toRadius: toRadius, animationDuration: animationDuration, animationKey: animationKey, animationDelegate: animationDelegate)
    }
    
    func pause() {
        if speed == 1 {
            timeOffset = convertTime(CACurrentMediaTime(), from: nil)
            speed = 0
        }
    }
    
    func resume() {
        if speed == 0 {
            speed = 1
            let pausedTime = timeOffset
            timeOffset = 0
            beginTime = 0
            beginTime = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        }
    }
}
