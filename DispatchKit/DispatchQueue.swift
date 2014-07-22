//
//  DispatchQueue.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

struct DispatchQueue: DispatchObject, DispatchResumable {

    let queue: dispatch_queue_t!

    init(raw queue: dispatch_queue_t!) {
        self.queue = queue
    }

    init(_ label: String! = nil, attr: DispatchQueueAttr = .Serial,
         qosClass: DispatchQOSClass = .Unspecified, relativePriority: Int = 0) {

        self.queue = dk_dispatch_queue_create_with_qos_class(label, attr.attr, qosClass, relativePriority)
    }


    func getContext() -> DispatchCookie {
        return dk_dispatch_get_context(queue)
    }

    func setContext(context: DispatchCookie) {
        dk_dispatch_set_context(queue, context)
    }


    func getSpecific(key: ConstUnsafePointer<Void>) -> DispatchCookie {
        return dk_dispatch_queue_get_specific(queue, key)
    }

    func setSpecific(key: ConstUnsafePointer<Void>, _ specific: DispatchCookie) {
        dk_dispatch_queue_set_specific(queue, key, specific)
    }


    var clabel: ConstUnsafePointer<CChar> {
        if queue {
            // this function never returns NULL, despite its documentation.
            return dispatch_queue_get_label(queue)
        }
        return ConstUnsafePointer<CChar>.null()
    }

    var label: String {
        let (s, _) = String.fromCStringRepairingIllFormedUTF8(clabel)
        return s ? s! : "(null)"
    }


    var isMainQueue: Bool {
        return label == "com.apple.main-thread"
    }

    var isGlobalQueue: Bool {
        return label.hasPrefix("com.apple.root.")
    }

    var isSystemQueue: Bool {
        return label.hasPrefix("com.apple.")
    }


    // NOTE set to nil to reset target queue to default
    func setTargetQueue(targetQueue: DispatchQueue) {
        assert(!isSystemQueue)
        dispatch_set_target_queue(queue, targetQueue.queue)
    }


    func suspend() {
        dispatch_suspend(queue)
    }

    func resume() {
        dispatch_resume(queue)
    }


    func sync(block: dispatch_block_t) {
        dispatch_sync(queue, block)
    }

    func barrierSync(block: dispatch_block_t) {
        assert(!isSystemQueue)
        dispatch_barrier_sync(queue, block)
    }

    func apply(iterations: Int, block: (Int) -> Void) {
        dispatch_apply(iterations.asUnsigned(), queue, { block($0.asSigned()) })
    }


    func async(block: dispatch_block_t) {
        dispatch_async(queue, block)
    }

    func async(group: DispatchGroup, block: dispatch_block_t) {
        dispatch_group_async(queue, group.group, block)
    }

    func barrierAsync(block: dispatch_block_t) {
        assert(!isSystemQueue)
        dispatch_barrier_async(queue, block)
    }


    func after(when: DispatchTime, block: dispatch_block_t) {
        dispatch_after(when.toRaw(), queue, block)
    }

}


struct DispatchCurrentQueue {

    func getSpecific(key: ConstUnsafePointer<Void>) -> DispatchCookie {
        return dk_dispatch_get_specific(key)
    }


    var clabel: ConstUnsafePointer<CChar> {
        return dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL)
    }

    var label: String {
        let (s, _) = String.fromCStringRepairingIllFormedUTF8(clabel)
        return s ? s! : "(null)"
    }

}
