EonilTree
=========
2017/10/03
Hoon H.

[![Build Status](https://travis-ci.org/eonil/tree.swift.svg?branch=master)](https://travis-ci.org/eonil/tree.swift)

A value-type tree structure.

How to Use
--------------

    var t = Tree<Int>(node: 111)
    t.subtrees.append(Tree<Int>(node: 222))
    t.subtrees[0].subtrees.append(Tree<Int>(node: 333))



Installation
------------
This library supports SPM and pre-configured Xcode project.

Though this support build and running with SPM and Linux target, unit-tests won't be
executed due to lack of PRGN implementation which is included in GameKit.



Maintenance
---------------
File name mainly follows major member name of its content.
`eq.swift` and `nq.swift` are supposed to be `==.swift` and `!=.swift`, but this makes trouble
with SPM build, and avoided.



License
-------
Licensed under "MIT License".
Contributions becomes same license.
