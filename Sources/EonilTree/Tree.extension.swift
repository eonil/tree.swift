//
//  Tree.extension.swift
//  Tree4
//
//  Created by Hoon H. on 2017/10/03.
//Copyright © 2017 Hoon H. All rights reserved.
//

public extension Tree {
    ///
    /// Total count of all nodes (inclusing `self`) in current subtree.
    /// About O(n) where n is total number of subnodes.
    ///
    public var count: Int {
        return subtrees.map({ $0.count }).reduce(0, +) + 1
    }
    private func checkedAt(at index: Int) -> Tree? {
        guard index < subtrees.count else { return nil }
        return subtrees[index]
    }
    private func checkedAt(at path: IndexPath) -> Tree? {
        switch path.count {
        case 0:     return self
        case 1:     return checkedAt(at: path[0])
        default:    return at(path.dropFirst())
        }
    }
    ///
    /// O(1)
    /// Use `subnodes[index]` for public interface.
    ///
    private func at(_ index: Int) -> Tree {
        return subtrees[index]
    }
    /// O(depth)
    public func at(_ path: IndexPath) -> Tree {
        switch path.count {
        case 0:     return self
        case 1:     return at(path[0])
        default:    return at(path.dropFirst())
        }
    }
    ///
    /// Get: O(depth)
    /// Set: O(depth)
    /// Assumes there's a node at the path. Program crashes if it isn't.
    /// Program crashes if `path.isEmpty`.
    /// If `path.isEmpty`, this replaces `self`.
    ///
    public subscript(path: IndexPath) -> Tree<Node> {
        get { return at(path) }
        set {
            if let i = path.first {
                let subpath = path.dropFirst()
                subtrees[i][subpath] = newValue
            }
            else {
                self = newValue
            }
        }
    }
    /// O(depth)
    /// Assumes there's a node at the path. Program crashes if it isn't.
    /// Program crashes if `path.isEmpty`.
    public mutating func insert(at path: IndexPath, _ subtree: Tree) {
        let (i, subpath) = path.splitFirst()
        switch subpath.count {
        case 0:
            subtrees.insert(subtree, at: i)
        default:
            subtrees[i].insert(at: subpath, subtree)
        }
    }
    ///
    /// O(depth)
    /// Assumes there's a node at the path. Program crashes if it isn't.
    /// Program crashes if `path.isEmpty`.
    ///
    public mutating func remove(at path: IndexPath) {
        let (i, subpath) = path.splitFirst()
        switch subpath.count {
        case 0:
            subtrees.remove(at: i)
        default:
            subtrees[i].remove(at: subpath)
        }
    }
}

private extension IndexPath {
    func splitFirst() -> (Int, IndexPath) {
        precondition(count >= 1)
        return (self[0], self.dropFirst())
    }
}
