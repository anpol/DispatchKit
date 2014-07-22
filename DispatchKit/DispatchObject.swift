//
//  DispatchObject.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

@objc public protocol DispatchCookie {
    // application-defined
}

public protocol DispatchObject {
    func getContext() -> DispatchCookie
    func setContext(context: DispatchCookie)
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
