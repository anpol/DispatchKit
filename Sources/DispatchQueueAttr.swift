//
//  DispatchQueueAttr.swift
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
