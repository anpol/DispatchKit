//
//  DispatchIOTests.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

class DispatchIOTests: XCTestCase {

    func testIOType() {
        XCTAssertEqual(DISPATCH_IO_STREAM, DispatchIOType.Stream.toRaw())
        XCTAssertEqual(DISPATCH_IO_RANDOM, DispatchIOType.Random.toRaw())
    }

    func testIOCloseFlag() {
        XCTAssertEqual(0, DispatchIOCloseFlags.Unspecified.toRaw())
        XCTAssertEqual(DISPATCH_IO_STOP, DispatchIOCloseFlags.Stop.toRaw())
    }

    func testIOIntervalFlag() {
        XCTAssertEqual(0, DispatchIOIntervalFlags.Unspecified.toRaw())
        XCTAssertEqual(DISPATCH_IO_STRICT_INTERVAL, DispatchIOIntervalFlags.Strict.toRaw())
    }

}
