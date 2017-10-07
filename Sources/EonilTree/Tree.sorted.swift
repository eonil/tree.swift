//
//  Tree.sorted.swift
//  EonilTree
//
//  Created by Hoon H. on 2017/10/07.
//
//

public extension Tree {
    ///
    /// Make a sorted array of all subtrees.
    ///
    /// This uses DFS to sort subtrees.
    /// Therefore, sorted result is also *topologocally sorted*.
    ///
    public func sorted() -> [Tree] {
        return sortedDepthFirst()
    }
    public func sortedDepthFirst() -> [Tree] {
        var a = [Tree]()
        visitUsingDFS { a.append($0) }
        return a
    }
    ///
    /// - Returns:
    ///     A sorted result of all subtrees by performing *Topological Sort*.
    ///
    public func sortedTopologically() -> [Tree] {
        return sortedDepthFirst()
    }
    private func visitUsingDFS(_ callback: (Tree) -> Void) {
        callback(self)
        for subtree in subtrees {
            subtree.visitUsingDFS(callback)
        }
    }
}
