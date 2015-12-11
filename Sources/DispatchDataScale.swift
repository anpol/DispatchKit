//
//  DispatchDataScale.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

struct DispatchDataScale<T> {

    static func toBytes(n: Int) -> Int {
        return n * sizeof(T)
    }

    static func fromBytes(i: Int) -> Int {
        let n = i / sizeof(T)
        assert(i == toBytes(n), "unscaling is not reversible")
        return n
    }

}
