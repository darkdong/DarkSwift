//
//  Bundle.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/7/19.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public extension Bundle {
    var appVersion: String? {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    var buildVersion: String? {
        return object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    var productName: String? {
        return object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String
    }
}
