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
                if let oldIndex = oldValue {
                    candidates[oldIndex].isSelected = false
                }
                if let newIndex = selectedIndex {
                    candidates[newIndex].isSelected = true
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
            selectedIndex = candidates.index(of: newSelected)
        } else {
            selectedIndex = nil
        }
    }
}

