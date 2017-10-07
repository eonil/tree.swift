//
//  Tree.CustomDebugStringConvertible.swift
//  EonilTree
//
//  Created by Hoon H. on 2017/10/07.
//
//

extension Tree: CustomDebugStringConvertible {
    ///
    /// Gets pretty-printed string which describes
    /// outline shape of this tree.
    ///
    /// This is very slow. DO NOT use this for production.
    ///
    public var debugDescription: String {
        func makeSubtreeString(_ a: (Int, Tree)) -> String {
            let (i, t) = a
            let s = t.debugDescription
            func makeLineString(_ b: (Int, String.SubSequence)) -> String {
                let (j, s) = b
                if j == 0 { return "- [\(i)]: \(s)" }
                return "  \(s)"
            }
            return s.split(separator: "\n").enumerated().map(makeLineString).joined(separator: "\n")
        }
        let sts = subtrees.enumerated().map(makeSubtreeString)
        let n = makeNodeString()
        let s = "\(n)\n" + sts.joined(separator: "\n")
        return s
    }
    private func makeNodeString() -> String {
        if let a = node as? CustomDebugStringConvertible {
            return a.debugDescription
        }
        if let a = node as? CustomStringConvertible {
            return a.description
        }
        return "\(node)"
    }
}
