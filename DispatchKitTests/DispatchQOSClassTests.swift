//
//  DispatchQOSClassTests.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

class DispatchQOSClassTests: XCTestCase {

    func testToRaw() {
        XCTAssertEqual(UInt(QOS_CLASS_UNSPECIFIED.value), DispatchQOSClass.Unspecified.toRaw())
        XCTAssertEqual(UInt(QOS_CLASS_USER_INTERACTIVE.value), DispatchQOSClass.UserInteractive.toRaw())
        XCTAssertEqual(UInt(QOS_CLASS_USER_INITIATED.value), DispatchQOSClass.UserInitiated.toRaw())
        XCTAssertEqual(UInt(QOS_CLASS_DEFAULT.value), DispatchQOSClass.Default.toRaw())
        XCTAssertEqual(UInt(QOS_CLASS_UTILITY.value), DispatchQOSClass.Utility.toRaw())
        XCTAssertEqual(UInt(QOS_CLASS_BACKGROUND.value), DispatchQOSClass.Background.toRaw())
    }

}
