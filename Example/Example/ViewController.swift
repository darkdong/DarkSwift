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

func standardLutImage(cubeEdgeLength: Int = 16) -> UIImage {
    let len = cubeEdgeLength
    var data = Data(capacity: len * len * len)
    
    for g in 0..<len {
        for b in 0..<len {
            for r in 0..<len {
                let rValue = UInt8(r * len + r)
                let gValue = UInt8(g * len + g)
                let bValue = UInt8(b * len + b)
                //                    let pixel = Data(bytes: [rValue, gValue, bValue, 0]) // RGBA big endian
                let pixel = Data(bytes: [0, bValue, gValue, rValue]) // RGBA little endian
                data.append(pixel)
            }
        }
    }
    return UIImage(data: data, bitmapInfo: .byteOrder32Little, width: len * len, height: len)!
}

class ViewController: UIViewController {
    @IBOutlet var textView: LineLimitedTextView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!

    var data: Data!
    var nsdata: NSData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var image: UIImage!
        let targetSize = CGSize(width: 100, height: 24)
        image = standardLutImage()
        print("image", image.size, image.scale)
//        image = image.rotate(by: -3, scale: 3)
        image = image.imageToFitSize(targetSize, paddingColor: .gray, scale: 2)
//        image = image.imageToFillSize(targetSize, scale: 2)
//        image = image.resize(to: targetSize)!
        print("processed image", image.size, image.scale)
        
        let imageView = UIImageView(image: image)
        imageView.center = view.frame.size.center
        view.addSubview(imageView)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            imageView.removeFromSuperview()
//        }
    }

    func test() {
        print("test")
    }
}

