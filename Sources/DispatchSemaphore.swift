//
//  DispatchSemaphore.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public struct DispatchSemaphore: DispatchObject, DispatchWaitable {

    public let semaphore: dispatch_semaphore_t!

    public var rawValue: dispatch_object_t! {
        return semaphore
    }

    public init(raw semaphore: dispatch_semaphore_t!) {
        self.semaphore = semaphore
    }

    public init(_ value: Int) {
        assert(0 <= value)
        self.semaphore = dispatch_semaphore_create(value)
    }


    public func wait() -> Int {
        // default argument is not permitted in protocol method in #swift
        return wait(.Forever)
    }

    public func wait(timeout: DispatchTime) -> Int {
        return dispatch_semaphore_wait(semaphore, timeout.rawValue)
    }

    public func signal() -> Int {
        return dispatch_semaphore_signal(semaphore)
    }

}
