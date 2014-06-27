//
//  DispatchQOSClass.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

typealias DispatchQueuePriority = DKDispatchQueuePriority

typealias DispatchQOSClass = DKDispatchQOSClass

extension DispatchQOSClass {

    // Returns best possible, yet approximate mapping.
    func toPriority() -> DispatchQueuePriority {
        return dk_dispatch_qos_class_to_priority(self)
    }

    // Returns mapping as specified in the documentation.
    static func fromPriority(priority: DispatchQueuePriority) -> DispatchQOSClass {
        return dk_dispatch_queue_priority_to_qos_class(priority)
    }

}
