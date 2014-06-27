//
//  DispatchSemaphore.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

struct DispatchSemaphore: DispatchObject {

    let semaphore: dispatch_semaphore_t!

    init(raw semaphore: dispatch_semaphore_t!) {
        self.semaphore = semaphore
    }

    init(_ value: Int) {
        assert(0 <= value)
        self.semaphore = dispatch_semaphore_create(value)
    }


    func getContext() -> DispatchCookie {
        return dk_dispatch_get_context(semaphore)
    }

    func setContext(context: DispatchCookie) {
        dk_dispatch_set_context(semaphore, context)
    }


    func wait(timeout: DispatchTime = .Forever) -> Int {
        return dispatch_semaphore_wait(semaphore, timeout.toRaw())
    }

    func signal() -> Int {
        return dispatch_semaphore_signal(semaphore)
    }

}
