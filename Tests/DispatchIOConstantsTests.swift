//
//  DispatchIOConstantsTests.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

class DispatchIOConstantsTests: XCTestCase {

    func testIOType() {
        XCTAssertEqual(DISPATCH_IO_STREAM, DispatchIOType.Stream.rawValue)
        XCTAssertEqual(DISPATCH_IO_RANDOM, DispatchIOType.Random.rawValue)
    }

    func testIOCloseFlag() {
        XCTAssertEqual(0, Int(DispatchIOCloseFlags.Unspecified.rawValue))
        XCTAssertEqual(DISPATCH_IO_STOP, DispatchIOCloseFlags.Stop.rawValue)
    }

    func testIOIntervalFlag() {
        XCTAssertEqual(0, Int(DispatchIOIntervalFlags.Unspecified.rawValue))
        XCTAssertEqual(DISPATCH_IO_STRICT_INTERVAL, DispatchIOIntervalFlags.Strict.rawValue)
    }

}
