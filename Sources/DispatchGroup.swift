//
//  DispatchGroup.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public struct DispatchGroup: DispatchObject, DispatchEnterable, DispatchWaitable {

    public typealias RawValue = dispatch_group_t

    @available(*, unavailable, renamed="rawValue")
    public var group: RawValue {
        return rawValue
    }

    public let rawValue: RawValue

    @available(*, unavailable, renamed="DispatchGroup(rawValue:)")
    public init(raw group: RawValue) {
        self.rawValue = group
    }

    public init(rawValue: RawValue) {
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
