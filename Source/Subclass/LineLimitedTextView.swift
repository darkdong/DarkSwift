//
//  AutoresizableTextView.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/3/5.
//  Copyright © 2017年 Dong. All rights reserved.
//

import UIKit

open class LineLimitedTextView: UITextView {
    public var minNumberOfLines = 1
    public var maxNumberOfLines = 3
    public var changeHeightFromBottom = false

    public var textDidChangeHandler: ((LineLimitedTextView, Notification) -> Void)?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func commonInit() {
        textContainer.lineFragmentPadding = 0
        textContainerInset = UIEdgeInsets.zero
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: .UITextViewTextDidChange, object: nil)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    public func calculateFittingHeight() -> CGFloat {
        let size = CGSize(width: frame.width - textContainerInset.left - textContainerInset.right - textContainer.lineFragmentPadding, height: CGFloat.infinity)
        let boundingRect = attributedText.boundingRect(with: size, options: [.usesLineFragmentOrigin], context: nil)
        let lineSpacing: CGFloat
        if attributedText.length > 0, let paragraphStyle = attributedText.attribute(NSAttributedStringKey.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle {
            lineSpacing = paragraphStyle.lineSpacing
        } else {
            lineSpacing = 0
        }
        let lineHeight = firstCharacterHeight + lineSpacing
        let numberOfLines = Int(((boundingRect.height + lineSpacing) / lineHeight).rounded())

//        print(boundingRect, "lineHeight", lineHeight, "lineSpacing", lineSpacing,  "numberOfLines", numberOfLines)

        let height: CGFloat
        if numberOfLines >= maxNumberOfLines {
            height = lineHeight * CGFloat(maxNumberOfLines)
        } else if numberOfLines <= minNumberOfLines {
            height = lineHeight * CGFloat(minNumberOfLines)
        } else {
            height = boundingRect.height
        }
        return ceil(height)
    }
    
    private var firstCharacterHeight: CGFloat {
        if attributedText.length > 0 {
            return attributedText.attributedSubstring(from: NSMakeRange(0, 1)).size().height
        } else {
            var attributes = [NSAttributedStringKey: Any]()
            if let font = font {
                attributes[.font] = font
            }
            if let color = textColor {
                attributes[.foregroundColor] = color
            }
            return NSAttributedString(string: "", attributes: attributes).size().height
        }
    }
    
    public func adjustHeight() {
        let newHeight = calculateFittingHeight()
        if changeHeightFromBottom {
            setHeightFromBottom(newHeight)
        } else {
            frame.size.height = newHeight
        }
    }
    
    // MARK: - UITextViewDelegate

    @objc func textDidChange(_ notification: Notification) {
        guard let atv = notification.object as? LineLimitedTextView, atv == self else {
            return
        }
        if let handler = textDidChangeHandler {
            handler(self, notification)
        } else {
            adjustHeight()
        }
        //            scrollRangeToVisible(selectedRange)
    }
}
