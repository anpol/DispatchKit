//
//  DispatchQueueAttrTests.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

class DispatchQueueAttrTests: XCTestCase {

    func testToRaw() {
        XCTAssertEqualObjects(DISPATCH_QUEUE_SERIAL, DispatchQueueAttr.Serial.attr)
        XCTAssertEqualObjects(DISPATCH_QUEUE_CONCURRENT, DispatchQueueAttr.Concurrent.attr)
    }

}
