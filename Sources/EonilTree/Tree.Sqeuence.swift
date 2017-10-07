//
//  Tree.Sqeuence.swift
//  EonilTree
//
//  Created by Hoon H. on 2017/10/07.
//
//

extension Tree: Sequence {
    public typealias Iterator = TreeLazyDepthFirstIterator<Node>
    ///
    /// Makes a default iterator for this tree.
    ///
    /// Default iterator is lazy DFS iterator. If you want to use another
    /// iteration method, you need to do it by yourself.
    ///
    public func makeIterator() -> Iterator {
        return Iterator(self)
    }
}
