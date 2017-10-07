//
//  Tree.==.swift
//  EonilTree
//
//  Created by Hoon H. on 2017/10/07.
//
//

public extension Tree where Node: Equatable {
    public static func == (_ a: Tree, _ b: Tree) -> Bool {
        return a.node == b.node && a.subtrees.count == b.subtrees.count && { () -> Bool in
            for i in 0..<a.subtrees.count {
                guard a.subtrees[i] == b.subtrees[i] else { return false }
            }
            return true
        }()
    }
}
