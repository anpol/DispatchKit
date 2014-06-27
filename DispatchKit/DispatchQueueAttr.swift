//
//  DispatchQueueAttr.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

struct DispatchQueueAttr {

    static let Serial = DispatchQueueAttr(raw: DISPATCH_QUEUE_SERIAL)
    static let Concurrent = DispatchQueueAttr(raw: DISPATCH_QUEUE_CONCURRENT)

    let attr: dispatch_queue_attr_t!

    init(raw attr: dispatch_queue_attr_t!) {
        self.attr = attr
    }

}
