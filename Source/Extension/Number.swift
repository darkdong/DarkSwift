//
//  Number.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/12/9.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public extension UInt32 {
    var random: UInt32 {
        return arc4random_uniform(self)
    }
}
