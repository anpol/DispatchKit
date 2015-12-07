//
//  DispatchQueueConstantsTests.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

// Reintroduce constants not available on iOS 7, need to test them anyway.
let QOS_CLASS_USER_INTERACTIVE_: UInt32 = 0x21
let QOS_CLASS_USER_INITIATED_: UInt32 = 0x19
let QOS_CLASS_DEFAULT_: UInt32 = 0x15
let QOS_CLASS_UTILITY_: UInt32 = 0x11
let QOS_CLASS_BACKGROUND_: UInt32 = 0x09
let QOS_CLASS_UNSPECIFIED_: UInt32 = 0x00

class DispatchQueueConstantsTests: XCTestCase {

    func testQueueAttr() {
        XCTAssert(DISPATCH_QUEUE_SERIAL === DispatchQueueAttr.Serial.rawValue)
        XCTAssert(DISPATCH_QUEUE_CONCURRENT === DispatchQueueAttr.Concurrent.rawValue)
    }

    func testQOSClass() {
        XCTAssertEqual(QOS_CLASS_UNSPECIFIED_, DispatchQOSClass.Unspecified.rawValue.rawValue)
        XCTAssertEqual(QOS_CLASS_USER_INTERACTIVE_, DispatchQOSClass.UserInteractive.rawValue.rawValue)
        XCTAssertEqual(QOS_CLASS_USER_INITIATED_, DispatchQOSClass.UserInitiated.rawValue.rawValue)
        XCTAssertEqual(QOS_CLASS_DEFAULT_, DispatchQOSClass.Default.rawValue.rawValue)
        XCTAssertEqual(QOS_CLASS_UTILITY_, DispatchQOSClass.Utility.rawValue.rawValue)
        XCTAssertEqual(QOS_CLASS_BACKGROUND_, DispatchQOSClass.Background.rawValue.rawValue)
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
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_HIGH, DispatchQueuePriority.High.rawValue)
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_DEFAULT, DispatchQueuePriority.Default.rawValue)
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_LOW, DispatchQueuePriority.Low.rawValue)
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_BACKGROUND, DispatchQueuePriority.Background.rawValue)
    }

}
