//
//  DispatchSemaphore.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public struct DispatchSemaphore: DispatchObject, DispatchWaitable {

    @available(*, unavailable, renamed="rawValue")
    public var semaphore: dispatch_semaphore_t {
        return rawValue
    }

    public let rawValue: dispatch_semaphore_t


    @available(*, unavailable, renamed="DispatchSemaphore(rawValue:)")
    public init(raw semaphore: dispatch_semaphore_t) {
        self.rawValue = semaphore
    }

    public init(rawValue: dispatch_semaphore_t) {
        self.rawValue = rawValue
    }

    public init!(_ value: Int) {
        assert(0 <= value)

        guard let rawValue = dispatch_semaphore_create(value) else {
            return nil
        }

        self.rawValue = rawValue
    }


    public func wait() -> Int {
        // default argument is not permitted in protocol method in #swift
        return wait(.Forever)
    }

    public func wait(timeout: DispatchTime) -> Int {
        return dispatch_semaphore_wait(rawValue, timeout.rawValue)
    }

    public func signal() -> Int {
        return dispatch_semaphore_signal(rawValue)
    }

}
