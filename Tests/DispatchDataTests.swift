//
//  DispatchDataTests.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

class DispatchDataTests: XCTestCase {

    var a: DispatchData<Int>!
    var b: DispatchData<Int>!
    var c: DispatchData<Int>!
    var d: DispatchData<Int>!

    override func setUp() {
        super.setUp()
        a = DispatchData([10, 11, 12, 13, 14])

        let bp = UnsafeMutablePointer<Int>.alloc(6)
        bp.initializeFrom([15, 16, 17, 18, 19, 20])
        b = DispatchData(bp, 6)

        c = a + b
        d = c[3..<8]
    }

    override func tearDown() {
        a = nil
        b = nil
        c = nil
        d = nil
        super.tearDown()
    }

    func testCount() {
        XCTAssertEqual(5, a.count)
        XCTAssertEqual(6, b.count)
        XCTAssertEqual(11, c.count)
        XCTAssertEqual(5, d.count)
    }

    func testApply() {
        var i = 0xA
        d.apply {
            (region, buffer) -> Bool in
            switch i {
            case 0xA:
                XCTAssert(self.a.data === region.data.data)
                XCTAssertEqual(0, region.offset)
                XCTAssertEqual(2, buffer.count)
                XCTAssertEqual(13, buffer.start[0])
                XCTAssertEqual(14, buffer.start[1])
            case 0xB:
                XCTAssert(self.b.data === region.data.data)
                XCTAssertEqual(2, region.offset)
                XCTAssertEqual(3, buffer.count)
                XCTAssertEqual(15, buffer.start[0])
                XCTAssertEqual(16, buffer.start[1])
                XCTAssertEqual(17, buffer.start[2])
            default:
                XCTAssert(false)
            }
            ++i
            return true
        }
    }

}
