//
//  Array.swift
//  DarkSwift
//
//  Created by Dark Dong on 2017/4/18.
//  Copyright © 2017年 Dark Dong. All rights reserved.
//

import Foundation

public extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

public extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

public extension Array {
    var randomIndex: Int {
        return Int(arc4random_uniform(UInt32(count)))
    }
    
    func randoms(_ count: Int ) -> [Element] {
        if self.count <= count {
            return self.shuffled()
        }
        var results: [Element] = []
        var temp = self
        var countToDo = count
        while countToDo > 0 {
            let random = temp.remove(at: temp.randomIndex)
            results.append(random)
            countToDo = countToDo - 1
        }
        return results
    }
    
    func loopedIndex(before i: Int) -> Int {
        let prevIndex = index(before: i)
        return prevIndex < startIndex ? endIndex - 1 : prevIndex
    }
    
    func loopedIndex(after i: Int) -> Int {
        let nextIndex = index(after: i)
        return nextIndex >= endIndex ? startIndex : nextIndex
    }
    
    //if processor is presented, return empty permutations
    //if processor is not presented, return all permutations
    func permutation(_ length: Int? = nil, processor: (([Element]) -> Void)? = nil) -> [[Element]] {
        var allPermutations: [[Element]] = []
        func _permutation(_ lengthToGo: Int, remainder: inout [Element], aPermutation: inout [Element]) {
            if lengthToGo == 0 {
                if let processor = processor {
                    processor(aPermutation)
                }else {
                    allPermutations.append(aPermutation)
                }
                return
            }
            for i in remainder.indices {
                let e = remainder.remove(at: i)
                aPermutation.append(e)
                _permutation(lengthToGo - 1, remainder: &remainder, aPermutation: &aPermutation)
                let _ = aPermutation.popLast()
                remainder.insert(e, at: i)
            }
        }
        
        let validLength: Int
        if let length = length {
            if length <= 0 || length > count {
                validLength = count
            }else {
                validLength = length
            }
        }else {
            validLength = count
        }
        
        var aPermutation: [Element] = []
        var remainder = self
        
        _permutation(validLength, remainder: &remainder, aPermutation: &aPermutation)
        return allPermutations
    }
}

public extension Array where Element: Comparable {
    func repeatablePermutation(_ length: Int? = nil, processor: (([Element]) -> Void)? = nil) -> [[Element]] {
        var allPermutations: [[Element]] = []
        func _repeatablePermutation(_ lengthToGo: Int, remainder: inout [Element], aPermutation: inout [Element]) {
            if lengthToGo == 0 {
                if let processor = processor {
                    processor(aPermutation)
                }else {
                    allPermutations.append(aPermutation)
                }
                return
            }
            
            var lastElement: Element? = nil
            for i in remainder.indices {
                if let lastElement = lastElement , lastElement == remainder[i] {
                    continue
                }
                let e = remainder.remove(at: i)
                aPermutation.append(e)
                _repeatablePermutation(lengthToGo - 1, remainder: &remainder, aPermutation: &aPermutation)
                let _ = aPermutation.popLast()
                remainder.insert(e, at: i)
                lastElement = e
            }
        }
        
        let validLength: Int
        if let length = length {
            if length <= 0 || length > count {
                validLength = count
            }else {
                validLength = length
            }
        }else {
            validLength = count
        }
        
        var aPermutation: [Element] = []
        var remainder = self.sorted()
        
        _repeatablePermutation(validLength, remainder: &remainder, aPermutation: &aPermutation)
        return allPermutations
    }
}

public extension Set {
    //if processor is presented, return empty combinations
    //if processor is not presented, return all combinations
    func combination(_ length: Int? = nil, processor: ((Set<Element>) -> Void)? = nil) -> Set<Set<Element>> {
        var allCombinations: Set<Set<Element>> = []
        func _combination(_ lengthToGo: Int, remainder: inout Set<Element>, selected: inout Set<Element>) {
            if lengthToGo == 1 {
                for e in remainder {
                    let aCombination = selected.union(Set<Element>(arrayLiteral: e))
                    if let processor = processor {
                        processor(aCombination)
                    }else {
                        allCombinations.insert(aCombination)
                    }
                }
                return
            }else if lengthToGo == remainder.count {
                let aCombination = selected.union(remainder)
                if let processor = processor {
                    processor(aCombination)
                }else {
                    allCombinations.insert(aCombination)
                }
                return
            }
            
            //divide combination (contains an element "e") to two sub combination: with e and without e
            let e = remainder.popFirst()!
            selected.insert(e)
            //subcombination with e
            _combination(lengthToGo - 1, remainder: &remainder, selected: &selected)
            selected.remove(e)
            //subcombination without e
            _combination(lengthToGo, remainder: &remainder, selected: &selected)
        }
        let validLength: Int
        if let length = length {
            if length <= 0 || length > count {
                validLength = count
            }else {
                validLength = length
            }
        }else {
            validLength = count
        }
        
        var selected: Set<Element> = []
        var remainder = self
        
        _combination(validLength, remainder: &remainder, selected: &selected)
        return allCombinations
    }
}
