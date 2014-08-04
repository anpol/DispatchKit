//
//  DispatchDataScale.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

struct DispatchDataScale<T> {

    static func toBytes(n: Int) -> UInt {
        let sizeofT = UInt(bitPattern: sizeof(T))
        return UInt(n) * sizeofT
    }

    static func fromBytes(i: UInt) -> Int {
        let sizeofT = UInt(bitPattern: sizeof(T))
        let n = Int(bitPattern: i / sizeofT)
        assert(i == toBytes(n), "unscaling is not reversible")
        return n
    }

}
