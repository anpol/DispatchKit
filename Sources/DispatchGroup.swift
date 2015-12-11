//
//  DispatchGroup.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public struct DispatchGroup: DispatchObject, DispatchEnterable, DispatchWaitable {

    public let group: dispatch_group_t!

    public var rawValue: dispatch_object_t! {
        return group
    }

    public init(raw group: dispatch_group_t!) {
        self.group = group
    }

    public init() {
        self.group = dispatch_group_create()
    }


    public func enter() {
        dispatch_group_enter(group)
    }

    public func leave() {
        dispatch_group_leave(group)
    }


    public func wait() -> Int {
        // default argument is not permitted in protocol method in #swift
        return wait(.Forever)
    }

    public func wait(timeout: DispatchTime) -> Int {
        return dispatch_group_wait(group, timeout.rawValue)
    }

    public func notify(queue: DispatchQueue, block: dispatch_block_t) {
        dispatch_group_notify(group, queue.queue, block)
    }


    // See also DispatchQueue.async(group,block)

}
