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
        
//        let data = CIFWColorCube.standardCubeData(dimension: cubeDimension)
//        let image = UIImage(data: data, width: cubeDimension, height: cubeDimension * cubeDimension)!
//        let image = UIImage(data: data)!
//        print("image", image.size, image.scale)
//        let targetSize = CGSize(width: 100, height: 24)
//        image = image.rotate(by: -3, scale: 3)
//        image = image.imageToFitSize(targetSize, paddingColor: .gray, scale: 2)
//        image = image.imageToFillSize(targetSize, scale: 2)
//        image = image.resize(to: targetSize)!
        
        let center = view.frame.size.center

        let image = #imageLiteral(resourceName: "pic.png")
        let imageView1 = UIImageView(image: image)
        imageView1.center = center + CGPoint(x: 0, y: -100)
        view.addSubview(imageView1)

        let cubeDimension = 16
        let cubeData = #imageLiteral(resourceName: "lut_path_country.png").data!
        let filter = CIFWColorCube(cubeDimension: cubeDimension, cubeData: cubeData)
        let filteredImage = image.filter(by: filter)
        
        let imageView2 = UIImageView(image: filteredImage)
        imageView2.center = center + CGPoint(x: 0, y: 100)
        view.addSubview(imageView2)

//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            imageView.removeFromSuperview()
//        }
    }

    func test() {
        print("test")
    }
}

