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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .black
        let text = "对常用设计模式有深刻认识此举"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        
        var attributes = [NSAttributedStringKey: Any]()
        attributes[.paragraphStyle] = paragraphStyle
        attributes[.kern] = 0.3
        
        let astring = NSMutableAttributedString(string: text, attributes: attributes)
        let rect = CGRect(center: view.frame.size.center, size: CGSize(width: 60, height: 20))
        let textView = LineLimitedTextView(frame: rect)
        textView.backgroundColor = .green
        textView.attributedText = astring
        textView.changeHeightFromBottom = true
        textView.adjustHeight()
        view.addSubview(textView)
//
//            let s1 = "s1".attributedString().addUnderline(style: .styleSingle, color: .red)
//
////            let s1 = NSAttributedString(string: "s1")
//            let s2 = NSAttributedString(string: "s2", attributes: [:])
//            print(s1)
//            print(s2)

            
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
    }

    func test() {
        print("test")
    }
}

