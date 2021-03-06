//
//  ==.swift
//  EonilTree
//
//  Created by Hoon H. on 2017/10/07.
//
//

///
/// Best:   O(1)
/// Worse:  O(n) where n is number of all subtrees.
///
public func == <T> (_ a: Array<Tree<T>>, _ b: Array<Tree<T>>) -> Bool where T: Equatable {
    return a.count == b.count && { () -> Bool in
        for i in 0..<a.count {
            guard a[i] == b[i] else { return false }
        }
        return true
    }()
}

