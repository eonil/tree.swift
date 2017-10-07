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
/// This iterator can include/exclude some subtrees selectively.
/// See `init` for details.
///
public struct TreeLazyDepthFirstIndexPathIterator<Node>: IteratorProtocol {
    private typealias Task = (pointer: IndexPath, pointee: Tree<Node>)
    private let isIncludedImpl: (Task) -> Bool
    private var stack = [Task]()
    ///
    /// - Parameter isIncluded:
    ///     A function which returns whether to include a subtree in iteration.
    ///     If this function returns `false` for a subtree, the whole
    ///     subtree will be excluded from iteration.
    ///     Default value is a function which always returns `true`.
    ///
    public  init(_ tree: Tree<Node>, _ isIncluded: @escaping (IndexPath, Tree<Node>) -> Bool = { _, _ in true }) {
        isIncludedImpl = { isIncluded($0.pointer, $0.pointee) }
        let idxp = IndexPath()
        let task = (idxp, tree)
        guard isIncludedImpl(task) else { return }
        stack.append(task)
    }
    public mutating func next() -> IndexPath? {
        guard stack.isEmpty == false else { return nil }
        let task = stack.removeLast()
        for i in (0..<task.pointee.subtrees.count).lazy.reversed() {
            let subtree = task.pointee.subtrees[i]
            let subpath = task.pointer.appending(i)
            let subtask = (subpath, subtree)
            guard isIncludedImpl(subtask) else { continue }
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

