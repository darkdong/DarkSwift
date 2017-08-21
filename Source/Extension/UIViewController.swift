//
//  UIViewController.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/8/18.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UIViewController {
    class func setNavigationBarBackItemImageOnly() {
        let method = class_getInstanceMethod(self, #selector(viewDidLoad))
        let swizzledMethod = class_getInstanceMethod(self, #selector(swizzledViewDidLoad))
        method_exchangeImplementations(method, swizzledMethod)
    }
    
    func swizzledViewDidLoad() {
        swizzledViewDidLoad()
        
        if navigationItem.backBarButtonItem == nil {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
}
