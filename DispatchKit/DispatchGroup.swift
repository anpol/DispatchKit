//
//  DispatchGroup.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

public struct DispatchGroup: DispatchObject, DispatchEnterable, DispatchWaitable {

    public let group: dispatch_group_t!

    public init(raw group: dispatch_group_t!) {
        self.group = group
    }

    public init() {
        self.group = dispatch_group_create()
    }


    public func getContext() -> DispatchCookie? {
        return dk_dispatch_get_context(group)
    }

    public func setContext(context: DispatchCookie?) {
        dk_dispatch_set_context(group, context)
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
