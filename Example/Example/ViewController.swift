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

    override func loadView() {
        let skview = SKView(frame: UIScreen.main.bounds)
        skview.isMultipleTouchEnabled = false
//        skview.showsFPS = true
//        skview.showsNodeCount = true
        skview.ignoresSiblingOrder = true
        view = skview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let skview = view as? SKView {
            let scene = SKScene(size: skview.frame.size)
            scene.backgroundColor = UIColor.darkGray
            skview.presentScene(scene)
            
            let rect = CGRect(center: scene.size.center, size: CGSize(width: 300, height: 240))
            let rectNode = SKShapeNode(rect: rect)
            rectNode.strokeColor = UIColor.clear
            rectNode.fillColor = UIColor.blue
            scene.addChild(rectNode)
            
            let size = CGSize(width: 40, height: 40)
            let n1 = SKSpriteNode(color: UIColor.cyan, size: size)
            let n2 = SKSpriteNode(color: UIColor.magenta, size: size)
            let n3 = SKSpriteNode(color: UIColor.yellow, size: size)
            
            let n4: SKNode = n3.clone()
            let n5: SKNode = n2.clone()
            let n6: SKNode = n1.clone()

            let nodes = [n1, n2, n3, n4, n5, n6]
            let tabAlign: Alignment = .tabular(2, 3, CGSize(width: 40, height: 40), CGPoint(x: 0.5, y: 0.5))

            for node in nodes {
                scene.addChild(node)
            }
//            scene.layoutChildren(nodes, alignment: .horizontal(.bottom), in: rect)
            scene.layoutChildren(nodes, alignment: tabAlign, in: rect)

        }else {
            view.backgroundColor = UIColor.darkGray
            
            let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 240))
            container.backgroundColor = UIColor.purple
            view.addSubview(container)
            let insets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
            let rect = container.frame.bounds.rect(byInsets: insets)
            let v1 = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            v1.backgroundColor = UIColor.cyan
            let v2 = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            v2.backgroundColor = UIColor.magenta
            let v3 = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            v3.backgroundColor = UIColor.yellow
            
            let v4: UIView = v3.clone()
            let v5: UIView = v2.clone()
            let v6: UIView = v1.clone()
            let views = [v1, v2, v3, v4, v5, v6]
            let tabAlign: Alignment = .tabular(2, 3, CGSize(width: 40, height: 40), CGPoint(x: 0, y: 0))
//            let views = [v1, v2, v3]
            for v in views {
                container.addSubview(v)
            }
            container.layoutSubviews(views, alignment: tabAlign, in: rect)
//            container.layoutSubviews([v1, v2, v3], alignment: .horizontal(.center), in: rect)
//            container.layoutSubviews([v1, v2, v3], alignment: .vertical(.center), in: rect)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

