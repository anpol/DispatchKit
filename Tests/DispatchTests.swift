//
//  DispatchTests.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

class DispatchTests: XCTestCase {

    func testMainQueue() {
        XCTAssert(dispatch_get_main_queue() === Dispatch.mainQueue.rawValue)
    }

    func testGlobalQueue() {
        XCTAssert(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) ===
            Dispatch.globalQueue.rawValue)
    }

}
