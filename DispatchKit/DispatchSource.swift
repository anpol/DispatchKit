//
//  DispatchSource.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

public struct DispatchSource: DispatchObject, DispatchResumable, DispatchCancelable {

    public let source: dispatch_source_t!

    public init(raw source: dispatch_source_t!) {
        self.source = source
    }

    public init(_ type: DispatchSourceType, handle: Int = 0, mask: UInt = 0, queue: dispatch_queue_t!) {
        self.source = dk_dispatch_source_create(type, handle, mask, queue)
    }


    public func getContext() -> DispatchCookie {
        return dk_dispatch_get_context(source)
    }

    public func setContext(context: DispatchCookie) {
        dk_dispatch_set_context(source, context)
    }


    public func suspend() {
        dispatch_suspend(source)
    }

    public func resume() {
        dispatch_resume(source)
    }


    public func setRegistrationHandler(handler: dispatch_block_t!) {
        dispatch_source_set_registration_handler(source, handler)
    }

    public func setEventHandler(handler: dispatch_block_t!) {
        dispatch_source_set_event_handler(source, handler)
    }

    public func setCancelHandler(handler: dispatch_block_t!) {
        dispatch_source_set_cancel_handler(source, handler)
    }


    public func cancel() {
        dispatch_source_cancel(source)
    }

    public func testCancel() -> Bool {
        return 0 != dispatch_source_testcancel(source)
    }


    public var handle: Int {
        return dispatch_source_get_handle(source).asSigned()
    }

    public var mask: UInt {
        return dispatch_source_get_mask(source)
    }

    public var data: Int {
        return dispatch_source_get_data(source).asSigned()
    }

    public func mergeData(value: Int) {
        dispatch_source_merge_data(source, value.asUnsigned())
    }

    public func setTimer(start: DispatchTime, interval: DispatchTimeDelta, leeway: DispatchTimeDelta) {
        dispatch_source_set_timer(source, start.toRaw(), interval.toRaw(), leeway.toRaw())
    }

}
