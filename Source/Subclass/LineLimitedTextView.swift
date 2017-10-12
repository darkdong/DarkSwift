//
//  DDTextView.swift
//  Dong
//
//  Created by Dark Dong on 2017/3/5.
//  Copyright © 2017年 Dong. All rights reserved.
//

import UIKit

open class LineLimitedTextView: UITextView {
    public var minNumberOfLines = 1
    public var maxNumberOfLines = 3
    public var changeHeightFromBottom = false
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        if textContainer == nil {
            self.textContainer.lineFragmentPadding = 0
        }
        textContainerInset = UIEdgeInsets.zero
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: .UITextViewTextDidChange, object: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func calculateHeight() -> CGFloat {
        let size = CGSize(width: frame.width - textContainerInset.left - textContainerInset.right - textContainer.lineFragmentPadding, height: CGFloat.infinity)
        let boundingRect = attributedText.boundingRect(with: size, options: [.usesLineFragmentOrigin], context: nil)
        let lineSpacing: CGFloat
        if attributedText.length > 0, let paragraphStyle = attributedText.attribute(NSAttributedStringKey.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle {
            lineSpacing = paragraphStyle.lineSpacing
        } else {
            lineSpacing = 0
        }
        let firstAttributedText = attributedText.attributedSubstring(from: NSMakeRange(0, 0))
        let lineHeight = firstAttributedText.size().height + lineSpacing
        let numberOfLines = Int(round(boundingRect.height / lineHeight))

        print(boundingRect, lineHeight, numberOfLines)

        let height: CGFloat
        if numberOfLines >= maxNumberOfLines {
            height = lineHeight * CGFloat(maxNumberOfLines) - lineSpacing
        } else if numberOfLines <= minNumberOfLines {
            height = lineHeight * CGFloat(minNumberOfLines) - lineSpacing
        } else {
            height = boundingRect.height
        }
        return ceil(height)
    }
    
    public func adjustHeight() {
        let newHeight = calculateHeight()
        if changeHeightFromBottom {
            setHeightFromBottom(newHeight)
        } else {
            frame.size.height = newHeight
        }
    }
    
    // MARK: - UITextViewDelegate

    @objc func textDidChange(_ notification: Notification) {
        adjustHeight()
        scrollRangeToVisible(selectedRange)
    }
}
