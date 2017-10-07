//
//  TreeLazyDepthFirstIterator.swift
//  EonilTree
//
//  Created by Hoon H. on 2017/10/06.
//
//

///
/// Iterates all subtrees in a tree using DFS and lazily.
///
/// This iterator copies the tree at first. Iteration result
/// does not change if you change content of source tree.
///
public struct TreeLazyDepthFirstIterator<Node>: IteratorProtocol {
    private var stack = [Tree<Node>]()
    
    public  init(_ tree: Tree<Node>) {
        stack.append(tree)
    }
    public mutating func next() -> Tree<Node>? {
        guard stack.isEmpty == false else { return nil }
        let tree = stack.removeLast()
        stack.append(contentsOf: tree.subtrees.lazy.reversed())
        return tree
    }
}

extension TreeLazyDepthFirstIterator: Sequence {
    public func makeIterator() -> TreeLazyDepthFirstIterator<Node> {
        return self
    }
}
