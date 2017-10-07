//
//  Node.swift
//  Tree4
//
//  Created by Hoon H. on 2017/10/03.
//Copyright © 2017 Hoon H. All rights reserved.
//

///
/// A tree.
///
/// A tree represents a node and all of its descendants.
///
/// Internally, this is a *persistent data structure*.
/// - Unchanged subtree will be shared between all versions.
/// - Mutating a subtree also mutates all subtrees up to the root.
/// - So, any operation is at least O(depth) excluding operation cost itself.
/// Though it looks expensive to pay O(depth) for all operations, but however
/// you implement, you would pay that much if you deal with a tree structure
/// unless you use reference-type magics. (which is far harder and error-prone)
///
public struct Tree<Node> {
    typealias Index = IndexPath
    fileprivate var impl: TreeImpl<Node>

    public init(node: Node) {
        impl = TreeImpl(node)
    }
    public init<S>(node: Node, subnodes: S) where S: Sequence, S.Element == Tree {
        impl = TreeImpl(node, Array(subnodes.lazy.map({ $0.impl })))
    }
    fileprivate init(_ impl: TreeImpl<Node>) {
        self.impl = impl
    }
    ///
    /// Value at root point of this tree.
    ///
    public var node: Node {
        get { return impl.node }
        set {
            cloneImplIfNeeded()
            impl.node = newValue
        }
    }
    public var subtrees: SubtreeCollection {
        get { return SubtreeCollection(impl.subtrees ) }
        set {
            cloneImplIfNeeded()
            impl.subtrees = newValue.raw
        }
    }
    private mutating func cloneImplIfNeeded() {
        if isKnownUniquelyReferenced(&impl) == false {
            impl = impl.cloned()
        }
    }
}


public extension Tree {
    public struct SubtreeCollection: RandomAccessCollection, RangeReplaceableCollection {
        public typealias Index = Int
        public typealias SubSequence = SubtreeCollection
        fileprivate var raw: [TreeImpl<Node>]

        public init() {
            raw = []
        }
        fileprivate init(_ raw: [TreeImpl<Node>]) {
            self.raw = raw
        }
        ///
        /// Number of nodes only in this collection.
        /// (does not count descendants)
        ///
        public var count: Int {
            return raw.count
        }
        public var startIndex: Int {
            return raw.startIndex
        }
        public var endIndex: Int {
            return raw.endIndex
        }
        public subscript(position: Int) -> Tree {
            get { return Tree<Node>(raw[position]) }
            set { raw[position] = newValue.impl }
        }
        public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C : Collection, R : RangeExpression, Tree<Node> == C.Element, Tree.SubtreeCollection.Index == R.Bound {
            raw.replaceSubrange(subrange, with: newElements.lazy.map({ $0.impl }))
        }
    }
}

private final class TreeImpl<T> {
    var node: T
    var subtrees = [TreeImpl]()
    init(_ v: T, _ ns: [TreeImpl] = []) {
        node = v
        subtrees = ns
    }
    func cloned() -> TreeImpl {
        return TreeImpl(node, subtrees)
    }
}
