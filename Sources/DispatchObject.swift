//
//  DispatchObject.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public protocol DispatchObject: RawRepresentable {
    typealias RawValue: dispatch_object_t
    var rawValue: RawValue { get }
}

public protocol DispatchResumable {
    func suspend()
    func resume()
}

public protocol DispatchEnterable {
    func enter()
    func leave()
}

public protocol DispatchWaitable {
    func wait(timeout: DispatchTime) -> Int
}

public protocol DispatchCancelable {
    func cancel()
    func testCancel() -> Bool
}
