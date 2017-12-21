//
//  UINavigationBar.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/8/30.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UINavigationBar {
    func hideHairline() {
		setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
		shadowImage = UIImage()
	}
}
