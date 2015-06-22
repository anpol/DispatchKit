//
//  Dispatch.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

public struct Dispatch {

    public static var currentQueue: DispatchCurrentQueue {
        return DispatchCurrentQueue()
    }

    public static var mainQueue: DispatchQueue {
        return DispatchQueue(raw: dk_dispatch_get_main_queue())
    }

    public static var globalQueue: DispatchQueue {
        return getGlobalQueue(priority: .Default)
    }

    public static func getGlobalQueue(priority priority: DispatchQueuePriority, flags: Int = 0) -> DispatchQueue {
        return DispatchQueue(raw: dispatch_get_global_queue(priority.rawValue, UInt(flags)))
    }

    public static func getGlobalQueue(qosClass qosClass: DispatchQOSClass, flags: Int = 0) -> DispatchQueue {
        let identifier = dk_dispatch_has_qos_class() ?
            Int(qosClass.rawValue) :
            qosClass.toPriority().rawValue

        return DispatchQueue(raw: dispatch_get_global_queue(identifier, UInt(flags)))
    }

}
