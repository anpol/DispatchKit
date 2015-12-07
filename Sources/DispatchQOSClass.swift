//
//  DispatchQOSClass.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public enum DKDispatchQOSClass {
    
    case Unspecified
    @available(iOS 8.0, *)
    case UserInteractive
    @available(iOS 8.0, *)
    case UserInitiated
    @available(iOS 8.0, *)
    case Default
    @available(iOS 8.0, *)
    case Utility
    @available(iOS 8.0, *)
    case Background
    
    public var rawValue: qos_class_t {
        if #available(iOS 8.0, *) {
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
        } else {
            return qos_class_t(0);
        }
    }
    
}

public enum DKDispatchQueuePriority {
    
    case High,
    Default,
    Low,
    Background
    
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

public typealias DispatchQueuePriority = DKDispatchQueuePriority

public typealias DispatchQOSClass = DKDispatchQOSClass

extension DispatchQOSClass {

    // Returns best possible, yet approximate mapping.
    public func toPriority() -> DispatchQueuePriority {
        switch self {
        case .UserInteractive:
            return .High
        case .UserInitiated:
            return .High
        case .Utility:
            return .Low
        case .Background:
            return .Background
        case .Default:
            return .Default
        case .Unspecified:
            return .Default
        }
    }

    // Returns mapping as specified in the documentation.
    public static func fromPriority(priority: DispatchQueuePriority) -> DispatchQOSClass {
        if #available(iOS 8.0, *) {
            switch priority {
            case .High:
                return .UserInitiated
            case .Low:
                return .Utility
            case .Background:
                return .Background
            case .Default:
                return .Default
            }
        } else {
            return .Unspecified
        }
    }

}
