//
//  DispatchObject.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

@objc protocol DispatchCookie {
    // application-defined
}

protocol DispatchObject {
    func getContext() -> DispatchCookie
    func setContext(context: DispatchCookie)
}


protocol DispatchResumable {
    func suspend()
    func resume()
}


protocol DispatchEnterable {
    func enter()
    func leave()
}


protocol DispatchWaitable {
    func wait(timeout: DispatchTime) -> Int
    func notify(queue: DispatchQueue, block: dispatch_block_t)
}


protocol DispatchCancelable {
    func cancel()
    func testCancel() -> Bool
}
