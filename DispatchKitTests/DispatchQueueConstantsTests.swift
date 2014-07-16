//
//  DispatchQueueConstantsTests.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

// Reintroduce constants not available on iOS 7, need to test them anyway.
let QOS_CLASS_USER_INTERACTIVE_: UInt = 0x21
let QOS_CLASS_USER_INITIATED_: UInt = 0x19
let QOS_CLASS_DEFAULT_: UInt = 0x15
let QOS_CLASS_UTILITY_: UInt = 0x11
let QOS_CLASS_BACKGROUND_: UInt = 0x09
let QOS_CLASS_UNSPECIFIED_: UInt = 0x00

class DispatchQueueConstantsTests: XCTestCase {

    func testQueueAttr() {
        XCTAssertEqualObjects(DISPATCH_QUEUE_SERIAL, DispatchQueueAttr.Serial.attr)
        XCTAssertEqualObjects(DISPATCH_QUEUE_CONCURRENT, DispatchQueueAttr.Concurrent.attr)
    }

    func testQOSClass() {
        XCTAssertEqual(QOS_CLASS_UNSPECIFIED_, DispatchQOSClass.Unspecified.toRaw())
        XCTAssertEqual(QOS_CLASS_USER_INTERACTIVE_, DispatchQOSClass.UserInteractive.toRaw())
        XCTAssertEqual(QOS_CLASS_USER_INITIATED_, DispatchQOSClass.UserInitiated.toRaw())
        XCTAssertEqual(QOS_CLASS_DEFAULT_, DispatchQOSClass.Default.toRaw())
        XCTAssertEqual(QOS_CLASS_UTILITY_, DispatchQOSClass.Utility.toRaw())
        XCTAssertEqual(QOS_CLASS_BACKGROUND_, DispatchQOSClass.Background.toRaw())
    }

    func testQOSClassToPriority() {
        XCTAssertEqual(DispatchQueuePriority.Default, DispatchQOSClass.Unspecified.toPriority())
        XCTAssertEqual(DispatchQueuePriority.High, DispatchQOSClass.UserInteractive.toPriority())
        XCTAssertEqual(DispatchQueuePriority.High, DispatchQOSClass.UserInitiated.toPriority())
        XCTAssertEqual(DispatchQueuePriority.Default, DispatchQOSClass.Default.toPriority())
        XCTAssertEqual(DispatchQueuePriority.Low, DispatchQOSClass.Utility.toPriority())
        XCTAssertEqual(DispatchQueuePriority.Background, DispatchQOSClass.Background.toPriority())
    }

    func testQOSClassFromPriority() {
        XCTAssertEqual(DispatchQOSClass.UserInitiated, DispatchQOSClass.fromPriority(.High))
        XCTAssertEqual(DispatchQOSClass.Default, DispatchQOSClass.fromPriority(.Default))
        XCTAssertEqual(DispatchQOSClass.Utility, DispatchQOSClass.fromPriority(.Low))
        XCTAssertEqual(DispatchQOSClass.Background, DispatchQOSClass.fromPriority(.Background))
    }

    func testQueuePriority() {
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_HIGH, DispatchQueuePriority.High.toRaw())
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_DEFAULT, DispatchQueuePriority.Default.toRaw())
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_LOW, DispatchQueuePriority.Low.toRaw())
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_BACKGROUND, DispatchQueuePriority.Background.toRaw())
    }

}
