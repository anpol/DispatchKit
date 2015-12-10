//
//  DispatchObject.swift
//  DispatchKit
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

public extension DispatchObject {
    
    func getContext<Cookie: DispatchCookie>() -> Cookie? {
        let context = dispatch_get_context(rawValue)
        if context == nil {
            return nil
        }
        return .Some(bridge(context))
    }
    func setContext<Cookie: DispatchCookie>(context: Cookie?) {
        let contextPtr = context.map { UnsafeMutablePointer<Void>(Unmanaged.passRetained($0).toOpaque()) } ?? nil
        dispatch_set_context(rawValue, contextPtr)
        dispatch_set_finalizer_f(rawValue, bridgeRelease)
    }
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
