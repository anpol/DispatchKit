//
//  DispatchQueueConstantsTests.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

// Reintroduce constants not available on iOS 7, need to test them anyway.
let QOS_CLASS_USER_INTERACTIVE_: Int = 0x21
let QOS_CLASS_USER_INITIATED_: Int = 0x19
let QOS_CLASS_DEFAULT_: Int = 0x15
let QOS_CLASS_UTILITY_: Int = 0x11
let QOS_CLASS_BACKGROUND_: Int = 0x09
let QOS_CLASS_UNSPECIFIED_: Int = 0x00

class DispatchQueueConstantsTests: XCTestCase {

    func testQueueAttr() {
        XCTAssert(DISPATCH_QUEUE_SERIAL === DispatchQueueAttr.Serial.rawValue)
        XCTAssert(DISPATCH_QUEUE_CONCURRENT === DispatchQueueAttr.Concurrent.rawValue)
    }

    func testQOSClass() {
        XCTAssertEqual(QOS_CLASS_UNSPECIFIED_, DispatchQOSClass.Unspecified.rawValue)
        XCTAssertEqual(QOS_CLASS_USER_INTERACTIVE_, DispatchQOSClass.UserInteractive.rawValue)
        XCTAssertEqual(QOS_CLASS_USER_INITIATED_, DispatchQOSClass.UserInitiated.rawValue)
        XCTAssertEqual(QOS_CLASS_DEFAULT_, DispatchQOSClass.Default.rawValue)
        XCTAssertEqual(QOS_CLASS_UTILITY_, DispatchQOSClass.Utility.rawValue)
        XCTAssertEqual(QOS_CLASS_BACKGROUND_, DispatchQOSClass.Background.rawValue)
    }

    func testPriorityFromQOSClass() {
        XCTAssertEqual(DispatchQueuePriority.Default, DispatchQueuePriority(qosClass: DispatchQOSClass.Unspecified))
        XCTAssertEqual(DispatchQueuePriority.High, DispatchQueuePriority(qosClass: DispatchQOSClass.UserInteractive))
        XCTAssertEqual(DispatchQueuePriority.High, DispatchQueuePriority(qosClass: DispatchQOSClass.UserInitiated))
        XCTAssertEqual(DispatchQueuePriority.Default, DispatchQueuePriority(qosClass: DispatchQOSClass.Default))
        XCTAssertEqual(DispatchQueuePriority.Low, DispatchQueuePriority(qosClass: DispatchQOSClass.Utility))
        XCTAssertEqual(DispatchQueuePriority.Background, DispatchQueuePriority(qosClass: DispatchQOSClass.Background))
    }

    func testQOSClassFromPriority() {
        XCTAssertEqual(DispatchQOSClass.UserInitiated, DispatchQOSClass(priority: .High))
        XCTAssertEqual(DispatchQOSClass.Default, DispatchQOSClass(priority: .Default))
        XCTAssertEqual(DispatchQOSClass.Utility, DispatchQOSClass(priority: .Low))
        XCTAssertEqual(DispatchQOSClass.Background, DispatchQOSClass(priority: .Background))
    }

    func testQueuePriority() {
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_HIGH, DispatchQueuePriority.High.rawValue)
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_DEFAULT, DispatchQueuePriority.Default.rawValue)
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_LOW, DispatchQueuePriority.Low.rawValue)
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_BACKGROUND, DispatchQueuePriority.Background.rawValue)
    }

}
