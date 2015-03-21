//
//  DispatchQueue.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

public struct DispatchQueue: DispatchObject, DispatchQueueObject, DispatchResumable {

    public let queue: dispatch_queue_t!

    public init(raw queue: dispatch_queue_t!) {
        self.queue = queue
    }

    public init(_ label: String! = nil, attr: DispatchQueueAttr = .Serial,
         qosClass: DispatchQOSClass = .Unspecified, relativePriority: Int = 0) {

        self.queue = dk_dispatch_queue_create_with_qos_class(label, attr.attr, qosClass, relativePriority)
    }


    public var clabel: UnsafePointer<CChar> {
        if queue != nil {
            // this function never returns NULL, despite its documentation.
            return dispatch_queue_get_label(queue)
        }
        return nil
    }

    public var label: String {
        let (s, _) = String.fromCStringRepairingIllFormedUTF8(clabel)
        return s ?? "(null)"
    }


    public var isMainQueue: Bool {
        return label == "com.apple.main-thread"
    }

    public var isGlobalQueue: Bool {
        return label.hasPrefix("com.apple.root.")
    }

    public var isSystemQueue: Bool {
        return label.hasPrefix("com.apple.")
    }


    public func getContext() -> DispatchCookie? {
        return dk_dispatch_get_context(queue)
    }

    public func setContext(context: DispatchCookie?) {
        dk_dispatch_set_context(queue, context)
    }


    public func getSpecific(key: UnsafePointer<Void>) -> DispatchCookie? {
        return dk_dispatch_queue_get_specific(queue, key)
    }

    public func setSpecific(key: UnsafePointer<Void>, _ specific: DispatchCookie?) {
        dk_dispatch_queue_set_specific(queue, key, specific)
    }

    // NOTE set to nil to reset target queue to default
    public func setTargetQueue(targetQueue: DispatchQueue?) {
        assert(!isSystemQueue)
        dispatch_set_target_queue(queue, targetQueue?.queue)
    }


    public func suspend() {
        dispatch_suspend(queue)
    }

    public func resume() {
        dispatch_resume(queue)
    }


    public func sync(block: dispatch_block_t) {
        dispatch_sync(queue, block)
    }

    public func barrierSync(block: dispatch_block_t) {
        assert(!isSystemQueue)
        dispatch_barrier_sync(queue, block)
    }

    public func apply(iterations: Int, block: (Int) -> Void) {
        dispatch_apply(iterations, queue, { block($0) })
    }


    public func async(block: dispatch_block_t) {
        dispatch_async(queue, block)
    }

    public func async(group: DispatchGroup, block: dispatch_block_t) {
        dispatch_group_async(queue, group.group, block)
    }

    public func barrierAsync(block: dispatch_block_t) {
        assert(!isSystemQueue)
        dispatch_barrier_async(queue, block)
    }


    public func after(when: DispatchTime, block: dispatch_block_t) {
        dispatch_after(when.rawValue, queue, block)
    }

}


public struct DispatchCurrentQueue {

    public func getSpecific(key: UnsafePointer<Void>) -> DispatchCookie? {
        return dk_dispatch_get_specific(key)
    }


    public var clabel: UnsafePointer<CChar> {
        return dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL)
    }

    public var label: String {
        let (s, _) = String.fromCStringRepairingIllFormedUTF8(clabel)
        return s ?? "(null)"
    }

}
