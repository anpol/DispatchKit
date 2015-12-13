//
//  DispatchQueue.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public struct DispatchQueue : DispatchObject, DispatchResumable {
    
    public typealias RawValue = dispatch_queue_t
    
    @available(*, unavailable, renamed="rawValue")
    public var queue: RawValue {
        return rawValue
    }

    public let rawValue: RawValue

    @available(*, unavailable, renamed="DispatchQueue(rawValue:)")
    public init(raw queue: RawValue) {
        self.rawValue = queue
    }
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }

    public init!(_ label: String! = nil,
                attr: DispatchQueueAttr = .Serial,
                qosClass: DispatchQOSClass = .Unspecified,
                relativePriority: Int = 0) {
        assert(Int(QOS_MIN_RELATIVE_PRIORITY)...0 ~= relativePriority,
               "Invalid parameter: relative_priority")

        if qosClass == .Unspecified {
            guard let rawValue = dispatch_queue_create(label, attr.rawValue) else {
                return nil
            }
            
            self.rawValue = rawValue
        } else if #available(iOS 8.0, *) {
            // iOS 8 and later: apply QOS class
            guard
                let qosAttr = dispatch_queue_attr_make_with_qos_class(
                    attr.rawValue, qosClass.rawClass, Int32(relativePriority)),
                let rawValue = dispatch_queue_create(label, qosAttr)
            else {
                return nil
            }
            
            self.rawValue = rawValue
        } else {
            guard let rawValue = dispatch_queue_create(label, attr.rawValue) else {
                return nil
            }
            
            self.rawValue = rawValue

            // iOS 7 and earlier: simulate QOS class by applying a target queue.
            let priority = DispatchQueuePriority(qosClass: qosClass)
            let target = dispatch_get_global_queue(priority.rawValue, 0)
            dispatch_set_target_queue(rawValue, target)
        }
    }

    public var clabel: UnsafePointer<CChar> {
        // this function never returns NULL, despite its documentation.
        return dispatch_queue_get_label(rawValue)
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

    // NOTE set to nil to reset target queue to default
    public func setTargetQueue(targetQueue: DispatchQueue?) {
        assert(!isSystemQueue)
        dispatch_set_target_queue(rawValue, targetQueue?.rawValue)
    }


    public func suspend() {
        dispatch_suspend(rawValue)
    }

    public func resume() {
        dispatch_resume(rawValue)
    }


    public func sync(block: dispatch_block_t) {
        dispatch_sync(rawValue, block)
    }

    public func barrierSync(block: dispatch_block_t) {
        assert(!isSystemQueue)
        dispatch_barrier_sync(rawValue, block)
    }

    public func apply(iterations: Int, block: (Int) -> Void) {
        dispatch_apply(iterations, rawValue, { block($0) })
    }


    public func async(block: dispatch_block_t) {
        dispatch_async(rawValue, block)
    }

    public func async(group: DispatchGroup, block: dispatch_block_t) {
        dispatch_group_async(group.rawValue, rawValue, block)
    }

    public func barrierAsync(block: dispatch_block_t) {
        assert(!isSystemQueue)
        dispatch_barrier_async(rawValue, block)
    }


    public func after(when: DispatchTime, block: dispatch_block_t) {
        dispatch_after(when.rawValue, rawValue, block)
    }

}

public struct DispatchCurrentQueue {
    public var clabel: UnsafePointer<CChar> {
        return dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL)
    }

    public var label: String {
        let (s, _) = String.fromCStringRepairingIllFormedUTF8(clabel)
        return s ?? "(null)"
    }
}
