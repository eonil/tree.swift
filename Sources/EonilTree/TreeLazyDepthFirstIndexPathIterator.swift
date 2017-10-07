//
//  TreeLazyDepthFirstIndexPathIterator.swift
//  EonilTree
//
//  Created by Hoon H. on 2017/10/07.
//
//

///
/// Iterates all index-paths to all subtrees in a tree using DFS and lazily.
///
/// This iterator copies the tree at first. Iteration result
/// does not change if you change content of source tree.
///
public struct TreeLazyDepthFirstIndexPathIterator<Node>: IteratorProtocol {
    private typealias Task = (pointer: IndexPath, pointee: Tree<Node>)
    private var stack = [Task]()
    public  init(_ tree: Tree<Node>) {
        let task = (IndexPath(), tree)
        stack.append(task)
    }
    public mutating func next() -> IndexPath? {
        guard stack.isEmpty == false else { return nil }
        let task = stack.removeLast()
        for i in (0..<task.pointee.subtrees.count).lazy.reversed() {
            let subpath = task.pointer.appending(i)
            let subtree = task.pointee.subtrees[i]
            let subtask = (subpath, subtree)
            stack.append(subtask)
        }
        return task.pointer
    }
}

extension TreeLazyDepthFirstIndexPathIterator: Sequence {
    public func makeIterator() -> TreeLazyDepthFirstIndexPathIterator<Node> {
        return self
    }
}

