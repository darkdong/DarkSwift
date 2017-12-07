//
//  HoleView.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/11/2.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

class HoleView: UIView {
    var holePaths = [UIBezierPath]()
        
    override func draw(_ rect: CGRect) {
        UIColor.clear.setFill()
        for holePath in holePaths {
            holePath.fill(with: .copy, alpha: 1)
        }
    }
}
