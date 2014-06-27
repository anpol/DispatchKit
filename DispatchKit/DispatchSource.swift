//
//  DispatchSource.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

struct DispatchSource: DispatchObject, DispatchResumable, DispatchCancelable {

    let source: dispatch_source_t!

    init(raw source: dispatch_source_t!) {
        self.source = source
    }

    init(_ type: DispatchSourceType, handle: Int = 0, mask: UInt = 0, queue: dispatch_queue_t!) {
        self.source = dk_dispatch_source_create(type, handle, mask, queue)
    }


    func getContext() -> DispatchCookie {
        return dk_dispatch_get_context(source)
    }

    func setContext(context: DispatchCookie) {
        dk_dispatch_set_context(source, context)
    }


    func suspend() {
        dispatch_suspend(source)
    }

    func resume() {
        dispatch_resume(source)
    }


    func setRegistrationHandler(handler: dispatch_block_t!) {
        dispatch_source_set_registration_handler(source, handler)
    }

    func setEventHandler(handler: dispatch_block_t!) {
        dispatch_source_set_event_handler(source, handler)
    }

    func setCancelHandler(handler: dispatch_block_t!) {
        dispatch_source_set_cancel_handler(source, handler)
    }


    func cancel() {
        dispatch_source_cancel(source)
    }

    func testCancel() -> Bool {
        return 0 != dispatch_source_testcancel(source)
    }


    var handle: Int {
        return dispatch_source_get_handle(source).asSigned()
    }

    var mask: UInt {
        return dispatch_source_get_mask(source)
    }

    var data: Int {
        return dispatch_source_get_data(source).asSigned()
    }

    func mergeData(value: Int) {
        dispatch_source_merge_data(source, value.asUnsigned())
    }

    func setTimer(start: DispatchTime, interval: DispatchTimeDelta, leeway: DispatchTimeDelta) {
        dispatch_source_set_timer(source, start.toRaw(), interval.toRaw(), leeway.toRaw())
    }

}
