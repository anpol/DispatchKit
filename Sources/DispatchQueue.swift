//
//  DispatchQueue.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public struct DispatchQueue : DispatchObject, DispatchResumable {
    
    public let queue: dispatch_queue_t!

    public var rawValue: dispatch_object_t! {
        return queue
    }

    public init(raw queue: dispatch_queue_t!) {
        self.queue = queue
    }

    public init(_ label: String! = nil,
                attr: DispatchQueueAttr = .Serial,
                qosClass: DispatchQOSClass = .Unspecified,
                relativePriority: Int = 0) {
        assert(Int(QOS_MIN_RELATIVE_PRIORITY)...0 ~= relativePriority,
               "Invalid parameter: relative_priority")

        if qosClass == .Unspecified {
            self.queue = dispatch_queue_create(label, attr.rawValue)
        } else if #available(iOS 8.0, *) {
            // iOS 8 and later: apply QOS class
            if let qosAttr = dispatch_queue_attr_make_with_qos_class(
                    attr.rawValue, qosClass.rawClass, Int32(relativePriority)) {
                self.queue = dispatch_queue_create(label, qosAttr)
            } else {
                self.queue = nil
            }
        } else {
            self.queue = dispatch_queue_create(label, attr.rawValue)

            // iOS 7 and earlier: simulate QOS class by applying a target queue.
            if let queue = self.queue {
                let priority = DispatchQueuePriority(qosClass: qosClass)
                let target = dispatch_get_global_queue(priority.rawValue, 0)
                dispatch_set_target_queue(queue, target)
            }
        }
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


    public func getSpecific<Cookie: DispatchCookie>(key: UnsafePointer<Void>) -> Cookie? {
        let specific = dispatch_get_specific(key)
        if specific == nil {
            return nil
        }
        
        return .Some(bridge(specific))
    }

/*
    public func setSpecific<Cookie: DispatchCookie>(key: UnsafePointer<Void>, _ specific: Cookie?) {
        let retained = specific.map { UnsafeMutablePointer<Void>(bridgeRetained($0)) }
        dispatch_queue_set_specific(queue, key, retained ?? nil) { ptr in
            release(ptr)
        }
    }
*/

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
        dispatch_group_async(group.group, queue, block)
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

    public func getSpecific<Cookie: DispatchCookie>(key: UnsafePointer<Void>) -> Cookie? {
        let specific: UnsafePointer<Void> = UnsafePointer(dispatch_get_specific(key))
        if specific == nil {
            return nil
        }
        return .Some(bridge(specific))
    }


    public var clabel: UnsafePointer<CChar> {
        return dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL)
    }

    public var label: String {
        let (s, _) = String.fromCStringRepairingIllFormedUTF8(clabel)
        return s ?? "(null)"
    }

}
