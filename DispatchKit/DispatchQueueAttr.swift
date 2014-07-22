//
//  DispatchQueueAttr.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

public struct DispatchQueueAttr {

    public static let Serial = DispatchQueueAttr(raw: DISPATCH_QUEUE_SERIAL)
    public static let Concurrent = DispatchQueueAttr(raw: DISPATCH_QUEUE_CONCURRENT)

    public let attr: dispatch_queue_attr_t!

    public init(raw attr: dispatch_queue_attr_t!) {
        self.attr = attr
    }

}
