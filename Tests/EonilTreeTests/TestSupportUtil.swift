//
//  TestSupportUtil.swift
//  EonilTree
//
//  Created by Hoon H. on 2017/10/07.
//
//

import GameKit
@testable import EonilTree

struct TestSupportUtil {
    ///
    /// - Parameter maxChildrenCount:
    ///     Defines maximum number of children.
    ///     Number of children can be `0..<maxChildrenCount`, and
    ///     adjusted to produce far more small numbers using cubic
    ///     curve. Number of subtrees don't get increased exponentially.
    ///
    /// - Parameter random:
    ///     You can designate a random generator to reproduce desired
    ///     result. For example, you can use exactly same state of
    ///     PRNG, and it will produce exactly same result.
    ///
    static func makeRandomStructuredTreeWithSequentialNode(depth: Int = 4, maxChildrenCount: Int = 32, random: GKRandom = sharedRandom, nodeSeed: MutableBox<Int> = MutableBox(0)) -> Tree<Int> {
        nodeSeed.value += 1
        var t = Tree<Int>(node: nodeSeed.value)
        guard depth > 0 else { return t }
        let n = abs(random.nextInt()) % maxChildrenCount
        let r = Float(n) / Float(maxChildrenCount)
        let r1 = r * r * r
        let n1 = Int(round(r1 * Float(maxChildrenCount)))
        let n2 = max(1, n1)
        for _ in 0..<n2 {
            let t1 = makeRandomStructuredTreeWithSequentialNode(depth: depth - 1, maxChildrenCount: maxChildrenCount, random: random, nodeSeed: nodeSeed)
            t.subtrees.append(t1)
        }
        return t
    }
    static func makeReproducibleRandom(seed: UInt64) -> GKRandom {
        return GKMersenneTwisterRandomSource(seed: seed)
    }
    private static let sharedRandom = GKMersenneTwisterRandomSource(seed: 0)
}
extension TestSupportUtil {
    final class MutableBox<T> {
        var value: T
        init(_ v: T) {
            value = v
        }
    }
}



