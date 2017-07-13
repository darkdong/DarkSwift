//
//  String.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/28.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public extension String {
    func hash(algorithm: Data.DigestAlgorithm, lowercase: Bool = true) -> String {
        return data(using: .utf8)!.hash(algorithm: algorithm, lowercase: lowercase)
    }

    func hmac(algorithm: Data.DigestAlgorithm, key: String, lowercase: Bool = true) -> String {
        return data(using: .utf8)!.hmac(algorithm: algorithm, keyData: key.data(using: .utf8)!, lowercase: lowercase)
    }
}
