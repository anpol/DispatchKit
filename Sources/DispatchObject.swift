//
//  DispatchObject.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public protocol DispatchCookie: class {
    // application-defined
}

public protocol DispatchObject {
    var rawValue: dispatch_object_t! { get }
    func getContext<Cookie: DispatchCookie>() -> Cookie?
    func setContext<Cookie: DispatchCookie>(context: Cookie?)
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
