//
//  DispatchGroup.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

struct DispatchGroup: DispatchObject, DispatchEnterable, DispatchWaitable {

    let group: dispatch_group_t!

    init(raw group: dispatch_group_t!) {
        self.group = group
    }

    init() {
        self.group = dispatch_group_create()
    }


    func getContext() -> DispatchCookie {
        return dk_dispatch_get_context(group)
    }

    func setContext(context: DispatchCookie) {
        dk_dispatch_set_context(group, context)
    }


    func enter() {
        dispatch_group_enter(group)
    }

    func leave() {
        dispatch_group_leave(group)
    }


    func wait() -> Int {
        // default argument is not permitted in protocol method in #swift
        return wait(.Forever)
    }

    func wait(timeout: DispatchTime) -> Int {
        return dispatch_group_wait(group, timeout.toRaw())
    }

    func notify(queue: DispatchQueue, block: dispatch_block_t) {
        dispatch_group_notify(group, queue.queue, block)
    }


    // See also DispatchQueue.async(group,block)

}
