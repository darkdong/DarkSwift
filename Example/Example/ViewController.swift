//
//  ViewController.swift
//  Example
//
//  Created by Dark Dong on 2017/4/2.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit
import SpriteKit
import DarkSwift

class ViewController: UIViewController {
    @IBOutlet var textView: LineLimitedTextView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!

    var data: Data!
    var nsdata: NSData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func test() {
        print("test")
    }
}

