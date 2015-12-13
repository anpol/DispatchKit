//
//  DispatchGroup.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public struct DispatchGroup: DispatchObject, DispatchEnterable, DispatchWaitable {

    @available(*, unavailable, renamed="rawValue")
    public var group: dispatch_group_t {
        return rawValue
    }

    @available(*, unavailable, renamed="DispatchGroup(rawValue:)")
    public init(raw group: dispatch_group_t) {
        self.rawValue = group
    }

    public let rawValue: dispatch_group_t

    public init(rawValue: dispatch_group_t) {
        self.rawValue = rawValue
    }

    public init!() {
        guard let rawValue = dispatch_group_create() else {
            return nil
        }

        self.rawValue = rawValue
    }


    public func enter() {
        dispatch_group_enter(rawValue)
    }

    public func leave() {
        dispatch_group_leave(rawValue)
    }


    public func wait() -> Int {
        // default argument is not permitted in protocol method in #swift
        return wait(.Forever)
    }

    public func wait(timeout: DispatchTime) -> Int {
        return dispatch_group_wait(rawValue, timeout.rawValue)
    }

    public func notify(queue: DispatchQueue, block: dispatch_block_t) {
        dispatch_group_notify(rawValue, queue.rawValue, block)
    }


    // See also DispatchQueue.async(group,block)

}
