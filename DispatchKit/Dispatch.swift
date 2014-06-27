//
//  Dispatch.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

struct Dispatch {

    static var currentQueue: DispatchCurrentQueue {
        return DispatchCurrentQueue()
    }

    static var mainQueue: DispatchQueue {
        return DispatchQueue(raw: dk_dispatch_get_main_queue())
    }

    static var globalQueue: DispatchQueue {
        return getGlobalQueue(priority: .Default)
    }

    static func getGlobalQueue(#priority: DispatchQueuePriority, flags: Int = 0) -> DispatchQueue {
        return DispatchQueue(raw: dispatch_get_global_queue(priority.toRaw(), flags.asUnsigned()))
    }

    static func getGlobalQueue(#qosClass: DispatchQOSClass, flags: Int = 0) -> DispatchQueue {
        let identifier = dk_dispatch_has_qos_class() ?
            qosClass.toRaw().asSigned() :
            qosClass.toPriority().toRaw()

        return DispatchQueue(raw: dispatch_get_global_queue(identifier, flags.asUnsigned()))
    }

}
