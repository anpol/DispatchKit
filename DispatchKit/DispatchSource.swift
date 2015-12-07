//
//  DispatchSource.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public struct DispatchSource: DispatchObject, DispatchResumable, DispatchCancelable {

    public let source: dispatch_source_t
    
    public var rawValue: dispatch_object_t {
        return source
    }

    public init(raw source: dispatch_source_t) {
        self.source = source
    }

    public init(_ type: DispatchSourceType, handle: UInt = 0, mask: UInt = 0, queue: dispatch_queue_t!) {
        self.source = dispatch_source_create(type.toOpaque(), handle, mask, queue)
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
        return Int(bitPattern: dispatch_source_get_handle(source))
    }

    public var mask: UInt {
        return dispatch_source_get_mask(source)
    }

    public var data: Int {
        return Int(bitPattern: dispatch_source_get_data(source))
    }

    public func mergeData(value: Int) {
        dispatch_source_merge_data(source, UInt(value))
    }

    public func setTimer(start: DispatchTime, interval: DispatchTimeDelta, leeway: DispatchTimeDelta) {
        dispatch_source_set_timer(source, start.rawValue, interval.rawValue, leeway.rawValue)
    }

}
