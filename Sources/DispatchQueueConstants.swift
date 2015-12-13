//
//  DispatchQueueConstants.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public enum DispatchQueueAttr {
    case Serial
    case Concurrent

    public var rawValue: dispatch_queue_attr_t! {
        switch self {
        case .Serial:
            return DISPATCH_QUEUE_SERIAL
        case .Concurrent:
            return DISPATCH_QUEUE_CONCURRENT
        }
    }
}

public enum DispatchQOSClass {

    case Unspecified
    case UserInteractive
    case UserInitiated
    case Default
    case Utility
    case Background

    // Performs mapping as specified in the documentation.
    public init(priority: DispatchQueuePriority) {
        if #available(iOS 8.0, *) {
            switch priority {
            case .High:
                self = .UserInitiated
            case .Low:
                self = .Utility
            case .Background:
                self = .Background
            case .Default:
                self = .Default
            }
        } else {
            self = .Unspecified
        }
    }

    @available(iOS 8.0, *)
    public var rawClass: qos_class_t {
        switch self {
        case .Unspecified:
            return QOS_CLASS_UNSPECIFIED
        case .UserInteractive:
            return QOS_CLASS_USER_INTERACTIVE
        case .UserInitiated:
            return QOS_CLASS_USER_INITIATED
        case .Default:
            return QOS_CLASS_DEFAULT
        case .Utility:
            return QOS_CLASS_UTILITY
        case .Background:
            return QOS_CLASS_BACKGROUND
        }
    }

    public var rawValue: Int {
        if #available(iOS 8.0, *) {
            return Int(rawClass.rawValue)
        } else {
            return 0
        }
    }

}

public enum DispatchQueuePriority {

    case High
    case Default
    case Low
    case Background

    // Performs best possible, yet approximate mapping.
    public init(qosClass: DispatchQOSClass) {
        switch qosClass {
        case .UserInteractive:
            self = .High
        case .UserInitiated:
            self = .High
        case .Utility:
            self = .Low
        case .Background:
            self = .Background
        case .Default:
            self = .Default
        case .Unspecified:
            self = .Default
        }
    }

    public var rawValue: dispatch_queue_priority_t {
        switch self {
        case .High:
            return DISPATCH_QUEUE_PRIORITY_HIGH
        case .Default:
            return DISPATCH_QUEUE_PRIORITY_DEFAULT
        case .Low:
            return DISPATCH_QUEUE_PRIORITY_LOW
        case .Background:
            return DISPATCH_QUEUE_PRIORITY_BACKGROUND
        }
    }

}
