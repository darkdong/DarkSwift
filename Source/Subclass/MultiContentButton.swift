//
//  DDButton.swift
//  DoraPrint
//
//  Created by Dark Dong on 2017/5/27.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import UIKit

extension UIControlState: Hashable {
    public var hashValue: Int {
        return Int(rawValue)
    }
}

open class MultiContentButton: UIButton {
    public typealias StateContent = [UIControlState: Content]
    
    public struct Content {
        public var text: String?
        public var textColor: UIColor?
        public var image: UIImage?
    }
    
    public var stateContentList: [StateContent] = [] {
        didSet {
            selectedIndex = 0
        }
    }
    
    public var selectedIndex = 0 {
        didSet {
            setStateContent(stateContentList[selectedIndex])
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        addTarget(self, action: #selector(setStateContentToNext), for: .touchUpInside)
    }
    
    func setStateContent(_ stateContent: StateContent) {
        for (state, content) in stateContent {
            setTitle(content.text, for: state)
            setTitleColor(content.textColor, for: state)
            setImage(content.image, for: state)
        }
    }

    @objc func setStateContentToNext() {
        guard !stateContentList.isEmpty else {
            return
        }
        selectedIndex = stateContentList.loopedIndex(after: selectedIndex)
    }
    
    //convenience for only normal state
    public func setNormalContentList(_ contents: [Content]) {
        stateContentList = contents.map { (content) -> StateContent in
            return [.normal: content]
        }
    }
    
    //convenience for other states
    public func addContentList(_ contents: [Content], for state: UIControlState) {
        for i in 0..<stateContentList.count {
            stateContentList[i][state] = contents[i]
        }
    }
}
