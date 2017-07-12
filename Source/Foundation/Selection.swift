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

public struct Chooser<T> where T: Equatable, T: Selectable {
    public var candidates: [T] = [] {
        didSet {
            if !allowsEmptySelection, !candidates.isEmpty {
                indexOfSelected = 0
            }
        }
    }
    public var indexOfSelected: Int? {
        didSet {
            if let i = indexOfSelected {
                if i < candidates.startIndex {
                    indexOfSelected = 0
                }
                if i >= candidates.endIndex {
                    indexOfSelected = candidates.endIndex - 1
                }
            } else {
                if !allowsEmptySelection {
                    indexOfSelected = 0
                }
            }
            
            if indexOfSelected != oldValue {
                if let oldIndex = oldValue {
                    var oldSelected = candidates[oldIndex]
                    oldSelected.isSelected = false
                }
                if let newIndex = indexOfSelected {
                    var newSelected = candidates[newIndex]
                    newSelected.isSelected = true
                }
            }
        }
    }
    public var allowsEmptySelection = false
    public var selected: T? {
        if let index = indexOfSelected {
            return candidates[index]
        } else {
            return nil
        }
    }
    
    public init() {
        
    }
    
    public mutating func select(_ newSelected: T?) {
        if let newSelected = newSelected {
            indexOfSelected = candidates.index(of: newSelected)
        } else {
            indexOfSelected = nil
        }
    }
}

