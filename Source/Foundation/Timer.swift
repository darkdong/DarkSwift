//
//  Timer.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/31.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public class Timer {
    var timer: Foundation.Timer?
    var handler: ((Timer) -> Void)!
    var userInfo: Any? {
        return timer?.userInfo
    }
    
    init(scheduleWithTimeInterval timeInterval: TimeInterval, repeats: Bool, userInfo: Any? = nil, handler: @escaping ((Timer) -> Void)) {
        self.handler = handler
        timer = Foundation.Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(Timer.fire), userInfo: userInfo, repeats: repeats)
    }
    
    deinit {
        NSLog("DarkSwift.Timer deinit")
        invalidate()
    }
    
    func invalidate() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func fire() {
        handler?(self)
    }
}

public class DisplayLink {
    var displayLink: CADisplayLink?
    var handler: ((DisplayLink) -> Void)!
    
    init(handler: @escaping ((DisplayLink) -> Void)) {
        self.handler = handler
        displayLink = CADisplayLink(target: self, selector: #selector(DisplayLink.fire))
        displayLink?.add(to: .main, forMode: .defaultRunLoopMode)
    }
    
    deinit {
        NSLog("DarkSwift.DisplayLink deinit")
        invalidate()
    }
    
    func invalidate() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc func fire() {
        handler?(self)
    }
}
