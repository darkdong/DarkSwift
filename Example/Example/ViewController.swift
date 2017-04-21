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
    var data: Data!
    var nsdata: NSData!
    
//    override func loadView() {
//        let skview = SKView(frame: UIScreen.main.bounds)
//        skview.isMultipleTouchEnabled = false
////        skview.showsFPS = true
////        skview.showsNodeCount = true
//        skview.ignoresSiblingOrder = true
//        view = skview
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let skview = view as? SKView {
            let scene = SKScene(size: skview.frame.size)
            scene.backgroundColor = UIColor.darkGray
            skview.presentScene(scene)
            
            let cnode = SKNode()
            cnode.position = scene.size.center
            scene.addChild(cnode)

            let bgrect = CGRect(center: scene.size.center, size: CGSize(width: 320, height: 320))
//            let bgrect = CGRect(origin: CGPoint.zero, size: CGSize(width: 320, height: 320))
//            let container = SKShapeNode(rect: bgrect)
            let container = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 320, height: 320))
            container.position = scene.size.center
            container.zPosition = -100
//            container.strokeColor = UIColor.clear
//            container.fillColor = UIColor.blue
            scene.addChild(container)
            
            print("scene anchor \(scene.anchorPoint) cnode anchor \(cnode.anchorPoint)")
            
            let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            let rect = bgrect.rect(byInsets: insets)

            func createSpriteNode(color: UIColor, size: CGSize) -> SKNode {
                let node = SKSpriteNode(color: color, size: size)
                return node
            }
            
            func createShapeNode(color: UIColor, size: CGSize) -> SKNode {
//                let node = SKShapeNode(rectOf: size)
                let node = SKShapeNode(rect: CGRect(center: CGPoint.zero, size: size))
                node.strokeColor = UIColor.clear
                node.fillColor = color
                return node
            }
            
            func createLabelNode(color: UIColor, size: CGSize) -> SKNode {
                let node = createSpriteNode(color: color, size: size)
                let label = SKLabelNode(text: "fg")
                label.fontColor = UIColor.black
                label.verticalAlignmentMode = .center
                node.addChild(label)
                return node
            }
            
            let n1 = createSpriteNode(color: UIColor.cyan, size: CGSize(width: 80, height: 40))
            let n2 = createShapeNode(color: UIColor.magenta, size: CGSize(width: 80, height: 100))
            let n3 = createLabelNode(color: UIColor.yellow, size: CGSize(width: 80, height: 80))
            print("sprite anchor \(n1.anchorPoint) shape anchor \(n2.anchorPoint)")

//            let n1 = createLabelNode(text: "fg", fontSize: 40, vmode: .center)
//            let n2 = createLabelNode(text: "fg", fontSize: 40, vmode: .top)
//            let n3 = createLabelNode(text: "fg", fontSize: 40, vmode: .bottom)

//            let n4: SKNode! = n3.clone()
//            let n5: SKNode! = n2.clone()
//            let n6: SKNode! = n1.clone()
//            let nodes: [SKNode] = [n1, n2, n3, n4, n5, n6]
//            let tabAlign: Alignment = .tabular(2, 3, CGSize(width: 40, height: 40))
//            scene.layoutChildren(nodes, alignment: tabAlign, in: rect)

            let crect = CGRect(center: CGPoint.zero, size: CGSize(width: 320, height: 320))
            let crect2 = crect.rect(byInsets: insets)

            let nodes = [n1, n2, n3]
//            container.layoutChildren(nodes, alignment: .horizontal(.bottom), insets: insets)
            SKNode.layoutNodes(nodes, alignment: .horizontal(.bottom), in: rect)
//            n3.position = CGPoint.zero
            
            for node in nodes {
                scene.addChild(node)
            }
        } else {
            view.backgroundColor = UIColor.white
            
//            let container = UIView(frame: CGRect(center: view.frame.size.center, size: CGSize(width: 320, height: 320)))
//            container.backgroundColor = UIColor.purple
//            view.addSubview(container)
//            let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//            let rect = container.frame.bounds.rect(byInsets: insets)
//            let v1 = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
//            v1.backgroundColor = UIColor.cyan
//            let v2 = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 100))
//            v2.backgroundColor = UIColor.magenta
//            let v3 = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
//            v3.backgroundColor = UIColor.yellow
//            
//            let views: [UIView] = [v1, v2, v3]
////            container.layoutSubviews([v1, v2, v3], alignment: .horizontal(.center), in: rect)
////            container.layoutSubviews([v1, v2, v3], alignment: .horizontal(.top), in: rect)
//            container.layoutSubviews([v1, v2, v3], alignment: .horizontal(.bottom), insets: insets)
//
////            container.layoutSubviews([v1, v2, v3], alignment: .vertical(.center), in: rect)
////            container.layoutSubviews([v1, v2, v3], alignment: .vertical(.left), in: rect)
////            container.layoutSubviews([v1, v2, v3], alignment: .vertical(.right), in: rect)
//
////            let v4: UIView! = v3.clone()
////            let v5: UIView! = v2.clone()
////            let v6: UIView! = v1.clone()
////            let views: [UIView] = [v1, v2, v3, v4, v5, v6]
////            let tabAlign: Alignment = .tabular(2, 3, CGSize(width: 80, height: 80))
////            container.layoutSubviews(views, alignment: tabAlign, in: rect)
////            container.layoutSubviews([v1, v2, v3], alignment: .horizontal(.center), in: rect)
//            
//            for v in views {
//                container.addSubview(v)
//            }
            
//            let btn = UIButton(title: "test", target: self, action: #selector(test))
            let btn = UIButton()
            btn.frame.size = CGSize(width: 100, height: 40)
            btn.setTitle("test", for: .normal)
            btn.backgroundColor = UIColor.blue
            btn.addTarget(self, action: #selector(test), for: .touchUpInside)
            view.addSubview(btn)
            
            let image = UIImage.originalLutImage()
            let imageView = UIImageView(image: image)
            imageView.tag = 666
            imageView.center = view.frame.size.center
            view.addSubview(imageView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func test() {
        print("test")
        view.viewWithTag(666)?.removeFromSuperview()
    }
    
    
}

