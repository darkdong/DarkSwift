//
//  UIColor.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/30.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(rgbValue: Int, alpha: CGFloat = 1) {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

	func rgbToHSV() -> (CGFloat, CGFloat, CGFloat) {
		let rgb = (ciColor.red, ciColor.green, ciColor.blue)
		
		var hsv: (CGFloat, CGFloat, CGFloat) = (0.0, 0.0, 0.0)
		
		let minV = min(rgb.0, rgb.1, rgb.2)
		let maxV = max(rgb.0, rgb.1, rgb.2)
		
		let chroma = maxV - minV
		hsv.2 = maxV
		
		if maxV != 0.0 {
			hsv.1 = chroma / maxV
		}
		
		if hsv.1 != 0.0 {
			if rgb.0 == maxV {
				hsv.0 = (rgb.1 - rgb.2) / chroma
			} else if rgb.1 == maxV {
				hsv.0 = 2.0 + (rgb.2 - rgb.0) / chroma
			} else {
				hsv.0 = 4.0 + (rgb.0 - rgb.1) / chroma
			}
			hsv.0 /= 6.0
			if hsv.0 < 0.0 {
				hsv.0 += 1.0
			}
		}
		
		return hsv
	}
}
