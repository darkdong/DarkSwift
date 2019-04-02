//
//  Selection.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/7/9.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public protocol Selectable {
    var isSelected: Bool {get set}
}

extension UIButton: Selectable {}

public struct ExclusiveSelection<T> where T: Equatable, T: Selectable {
    public var candidates: [T] = [] {
        didSet {
            if !allowsEmptySelection, !candidates.isEmpty {
                selectedIndex = 0
            }
        }
    }
    public var selectedIndex: Int? {
        didSet {
            if let i = selectedIndex {
                if i < candidates.startIndex {
                    selectedIndex = 0
                }
                if i >= candidates.endIndex {
                    selectedIndex = candidates.endIndex - 1
                }
            } else {
                if !allowsEmptySelection {
                    selectedIndex = 0
                }
            }
            
            if selectedIndex != oldValue {
                // NOTE: set property of element in candidates directly will trigger [candidates didSet], i.e. candidates[oldIndex].isSelected = xxx
                // To avoid triggering [candidates didSet], set property of element in two steps

                if let index = oldValue {
                    var oldSelected = candidates[index]
                    oldSelected.isSelected = false
                }
                if let index = selectedIndex {
                    var newSelected = candidates[index]
                    newSelected.isSelected = true
                }
                didSelectHandler?(oldValue, selectedIndex)
            }
        }
    }
    public var didSelectHandler: ((_ deselectedIndex: Int?, _ selectedIndex: Int?) -> Void)?
    public var allowsEmptySelection = false
    public var selected: T? {
        if let index = selectedIndex {
            return candidates[index]
        } else {
            return nil
        }
    }
    
    public init() {
        
    }
    
    public mutating func select(_ newSelected: T?) {
        if let newSelected = newSelected {
			selectedIndex = candidates.firstIndex(of: newSelected)
        } else {
            selectedIndex = nil
        }
    }
}

