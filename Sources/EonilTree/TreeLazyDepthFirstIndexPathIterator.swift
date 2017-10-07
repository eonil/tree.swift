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
/// This iterator can skip some node selectively. See `init` for details.
///
public struct TreeLazyDepthFirstIndexPathIterator<Node>: IteratorProtocol {
    private typealias Task = (pointer: IndexPath, pointee: Tree<Node>)
    private let isIncluded: (Task) -> Bool
    private var stack = [Task]()
    ///
    /// - Parameter skip:
    ///     A function which returns whether to skip a subtree or not.
    ///     If this function returns `true` for a subtree, the whole
    ///     subtree will be excluded from iteration.
    ///     Default value is a function which always returns false.
    ///
    public  init(_ tree: Tree<Node>, skip: @escaping (IndexPath, Tree<Node>) -> Bool = { _, _ in false }) {
        isIncluded = { skip($0.pointer, $0.pointee) == false }
        let idxp = IndexPath()
        let task = (idxp, tree)
        guard isIncluded(task) else { return }
        stack.append(task)
    }
    public mutating func next() -> IndexPath? {
        guard stack.isEmpty == false else { return nil }
        let task = stack.removeLast()
        for i in (0..<task.pointee.subtrees.count).lazy.reversed() {
            let subtree = task.pointee.subtrees[i]
            let subpath = task.pointer.appending(i)
            let subtask = (subpath, subtree)
            guard isIncluded(subtask) else { continue }
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

