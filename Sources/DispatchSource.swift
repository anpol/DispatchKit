//
//  DispatchSource.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public struct DispatchSource: DispatchObject, DispatchResumable, DispatchCancelable {

    public typealias RawValue = dispatch_source_t

    @available(*, unavailable, renamed="rawValue")
    public var source: RawValue {
        return rawValue
    }

    public let rawValue: RawValue

    @available(*, unavailable, renamed="DispatchSource(rawValue:)")
    public init(raw source: dispatch_source_t!) {
        self.rawValue = source
    }

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }

    public init!(_ type: DispatchSourceType, handle: UInt = 0, mask: UInt = 0, queue: DispatchQueue) {
        guard let rawValue = dispatch_source_create(type.toOpaque(), handle, mask, queue.rawValue) else {
            return nil
        }

        self.rawValue = rawValue
    }


    public func suspend() {
        dispatch_suspend(rawValue)
    }

    public func resume() {
        dispatch_resume(rawValue)
    }


    public func setRegistrationHandler(handler: dispatch_block_t!) {
        dispatch_source_set_registration_handler(rawValue, handler)
    }

    public func setEventHandler(handler: dispatch_block_t!) {
        dispatch_source_set_event_handler(rawValue, handler)
    }

    public func setCancelHandler(handler: dispatch_block_t!) {
        dispatch_source_set_cancel_handler(rawValue, handler)
    }


    public func cancel() {
        dispatch_source_cancel(rawValue)
    }

    public func testCancel() -> Bool {
        return 0 != dispatch_source_testcancel(rawValue)
    }


    public var handle: Int {
        return Int(bitPattern: dispatch_source_get_handle(rawValue))
    }

    public var mask: UInt {
        return dispatch_source_get_mask(rawValue)
    }

    public var data: Int {
        return Int(bitPattern: dispatch_source_get_data(rawValue))
    }

    public func mergeData(value: Int) {
        dispatch_source_merge_data(rawValue, UInt(value))
    }

    public func setTimer(start: DispatchTime, interval: DispatchTimeDelta, leeway: DispatchTimeDelta) {
        dispatch_source_set_timer(rawValue, start.rawValue, interval.rawValue, leeway.rawValue)
    }

}
