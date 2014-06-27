//
//  DispatchTests.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

class DispatchTests: XCTestCase {

    func testMainQueue() {
        XCTAssertEqualObjects(dk_dispatch_get_main_queue(), Dispatch.mainQueue.queue)
    }

    func testGlobalQueue() {
        XCTAssertEqualObjects(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
            Dispatch.globalQueue.queue)
    }

}
