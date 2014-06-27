//
//  DispatchDataScale.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

struct DispatchDataScale<T> {

    static func toBytes(i: Int) -> UInt {
        return (i * sizeof(T)).asUnsigned()
    }

    static func fromBytes(i: UInt) -> Int {
        let n = (i / sizeof(T).asUnsigned())
        assert(i == n * sizeof(T).asUnsigned(), "unscaling is not reversible")
        return n.asSigned()
    }

}
