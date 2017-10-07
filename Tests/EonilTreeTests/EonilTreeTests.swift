import XCTest
@testable import EonilTree



class EonilTreeTests: XCTestCase {
    static var allTests = [
        ("testTreeInitAndDeinit", testTreeInitAndDeinit),
        ("testTreeAppending", testTreeAppending),
        ("testLazyDFSIterator", testLazyDFSIterator),
        ("testLazyDFSIterator2", testLazyDFSIterator2),
        ("testLazyDFSIteratorWithSmallRandomTree1", testLazyDFSIteratorWithSmallRandomTree1),
        ("testLazyDFSIteratorWithSmallRandomTree2", testLazyDFSIteratorWithSmallRandomTree2),
        ("testLazyDFSIteratorWithManySmallRandomTrees", testLazyDFSIteratorWithManySmallRandomTrees),
        ("testLazyDFSIteratorWithRandomTree", testLazyDFSIteratorWithRandomTree),
        ("testLazyDFSIteratorWithManyRandomTrees", testLazyDFSIteratorWithManyRandomTrees),
    ]

    func testTreeInitAndDeinit() {
        typealias T = Tree<Int>
        let t = T(node: 111)
        XCTAssertEqual(t.node, 111)
    }
    func testTreeAppending() {
        typealias T = Tree<Int>
        var t = T(node: 111)
        t.subtrees.append(T(node: 222))
        XCTAssertEqual(t.count, 2)
        XCTAssertEqual(t[[]].node, 111)
        XCTAssertEqual(t[[0]].node, 222)
    }
    func testLazyDFSIterator() {
        typealias T = Tree<Int>
        var t = Tree(node: 111)
        t.insert(at: [0], Tree(node: 222))
        t.insert(at: [0, 0], Tree(node: 333))
        t.insert(at: [0, 0, 0], Tree(node: 444))
        t.insert(at: [0, 0, 0, 0], Tree(node: 555))
        XCTAssertEqual(t.count, 5)
        let iter = TreeLazyDepthFirstIterator(t)
        let a = Array(iter)
        XCTAssertEqual(a[0].node, 111)
        XCTAssertEqual(a[1].node, 222)
        XCTAssertEqual(a[2].node, 333)
        XCTAssertEqual(a[3].node, 444)
        XCTAssertEqual(a[4].node, 555)
        let b = t.sortedTopologically()
        XCTAssert(a == b)
    }
    func testLazyDFSIterator2() {
        typealias T = Tree<Int>
        var t = Tree(node: 111)
        t.insert(at: [0], Tree(node: 222))
        t.insert(at: [0, 0], Tree(node: 555))
        t.insert(at: [0, 0], Tree(node: 444))
        t.insert(at: [0, 0], Tree(node: 333))
        XCTAssertEqual(t.count, 5)
        let iter = TreeLazyDepthFirstIterator(t)
        let a = Array(iter)
        XCTAssertEqual(a[0].node, 111)
        XCTAssertEqual(a[1].node, 222)
        XCTAssertEqual(a[2].node, 333)
        XCTAssertEqual(a[3].node, 444)
        XCTAssertEqual(a[4].node, 555)
        let b = t.sorted()
        XCTAssert(a == b)
    }
    func testLazyDFSIteratorWithSmallRandomTree1() {
        let t = TestSupportUtil.makeRandomStructuredTreeWithSequentialNode(depth: 2, maxChildrenCount: 2)
        let iter = TreeLazyDepthFirstIterator(t)
        let iterated = Array(iter)
        let sorted = t.sorted()
        XCTAssert(iterated == sorted)
    }
    func testLazyDFSIteratorWithSmallRandomTree2() {
        let t = TestSupportUtil.makeRandomStructuredTreeWithSequentialNode(depth: 4, maxChildrenCount: 4)
        let iter = TreeLazyDepthFirstIterator(t)
        let iterated = Array(iter)
        let sorted = t.sorted()
        XCTAssert(iterated == sorted)
    }
    func testLazyDFSIteratorWithManySmallRandomTrees() {
        let r = TestSupportUtil.makeReproducibleRandom(seed: 0)
        for _ in 0..<1024 {
            let t = TestSupportUtil.makeRandomStructuredTreeWithSequentialNode(depth: 4, maxChildrenCount: 4, random: r)
            let iter = TreeLazyDepthFirstIterator(t)
            let iterated = Array(iter)
            let sorted = t.sorted()
            XCTAssert(iterated == sorted)
        }
    }
    func testLazyDFSIteratorWithRandomTree() {
        let t = TestSupportUtil.makeRandomStructuredTreeWithSequentialNode()
        let iter = TreeLazyDepthFirstIterator(t)
        let iterated = Array(iter)
        let sorted = t.sorted()
        print(iterated)
        print(sorted)
        XCTAssert(iterated == sorted)
    }
    func testLazyDFSIteratorWithManyRandomTrees() {
        let r = TestSupportUtil.makeReproducibleRandom(seed: 0)
        for _ in 0..<64 {
            let t = TestSupportUtil.makeRandomStructuredTreeWithSequentialNode(random: r)
            let iter = TreeLazyDepthFirstIterator(t)
            let iterated = Array(iter)
            let sorted = t.sorted()
            XCTAssert(iterated == sorted)
        }
    }
}

extension Tree: CustomStringConvertible {
    public var description: String {
        return "\(node)"
    }
}
