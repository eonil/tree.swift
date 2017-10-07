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
    private var queue = [Tree<Node>]()
    
    public  init(_ tree: Tree<Node>) {
        queue.append(tree)
    }
    public mutating func next() -> Tree<Node>? {
        guard queue.isEmpty == false else { return nil }
        let tree = queue.removeFirst()
        queue.insert(contentsOf: tree.subtrees, at: 0)
        return tree
    }
}

extension TreeLazyDepthFirstIterator: Sequence {
    public func makeIterator() -> TreeLazyDepthFirstIterator<Node> {
        return self
    }
}
