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
        let dimension = 16
        let data = CIFWColorCube.standardColorCubeData(cubeDimension: dimension)
        let image = UIImage(data: data, width: dimension, height: dimension * dimension)!
        
        let weights: [CGFloat] = [0,1,0,0,1,0,0,0,0]
        let filter = CIFWConvolution(kind: .CIConvolution3X3, weights: weights, bias: -0.3)
        let filteredImage = image.filter(by: filter)
        print("filteredImage", filteredImage?.size, filteredImage?.scale)
    }

    func test() {
        print("test")
    }
}

