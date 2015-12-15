//
//  Dispatch.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public struct Dispatch {

    public static var currentQueue: DispatchCurrentQueue {
        return DispatchCurrentQueue()
    }

    public static var mainQueue: DispatchQueue {
        return DispatchQueue(rawValue: dispatch_get_main_queue())
    }

    public static var globalQueue: DispatchQueue {
        return getGlobalQueue(priority: .Default)
    }

    public static func getGlobalQueue(priority priority: DispatchQueuePriority, flags: Int = 0) -> DispatchQueue {
        return DispatchQueue(rawValue: dispatch_get_global_queue(priority.rawValue, UInt(flags)))
    }

    public static func getGlobalQueue(qosClass qosClass: DispatchQOSClass, flags: Int = 0) -> DispatchQueue {
        let identifier: Int
        if #available(iOS 8.0, *) {
            identifier = qosClass.rawValue
        } else {
            identifier = DispatchQueuePriority(qosClass: qosClass).rawValue
        }

        return DispatchQueue(rawValue: dispatch_get_global_queue(identifier, UInt(flags)))
    }

}
