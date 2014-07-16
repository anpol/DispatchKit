//
//  DispatchQueueConstantsTests.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

class DispatchQueueConstantsTests: XCTestCase {

    func testQueueAttr() {
        XCTAssertEqualObjects(DISPATCH_QUEUE_SERIAL, DispatchQueueAttr.Serial.attr)
        XCTAssertEqualObjects(DISPATCH_QUEUE_CONCURRENT, DispatchQueueAttr.Concurrent.attr)
    }

    func testQOSClass() {
        XCTAssertEqual(UInt(QOS_CLASS_UNSPECIFIED.value), DispatchQOSClass.Unspecified.toRaw())
        XCTAssertEqual(UInt(QOS_CLASS_USER_INTERACTIVE.value), DispatchQOSClass.UserInteractive.toRaw())
        XCTAssertEqual(UInt(QOS_CLASS_USER_INITIATED.value), DispatchQOSClass.UserInitiated.toRaw())
        XCTAssertEqual(UInt(QOS_CLASS_DEFAULT.value), DispatchQOSClass.Default.toRaw())
        XCTAssertEqual(UInt(QOS_CLASS_UTILITY.value), DispatchQOSClass.Utility.toRaw())
        XCTAssertEqual(UInt(QOS_CLASS_BACKGROUND.value), DispatchQOSClass.Background.toRaw())
    }

    func testQueuePriority() {
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_HIGH, DispatchQueuePriority.High.toRaw())
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_DEFAULT, DispatchQueuePriority.Default.toRaw())
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_LOW, DispatchQueuePriority.Low.toRaw())
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_BACKGROUND, DispatchQueuePriority.Background.toRaw())
    }

}
