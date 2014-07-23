//
//  DispatchQueueTests.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

class DispatchQueueTests: XCTestCase {

    var foo = DispatchQueue("DispatchQueueTests.foo")
    var bar = DispatchQueue("DispatchQueueTests.bar")

    func testLabel() {
        XCTAssertEqual("DispatchQueueTests.foo", foo.label)
        foo.sync {
            XCTAssertEqual("DispatchQueueTests.foo", Dispatch.currentQueue.label)
        }
        XCTAssertEqual("DispatchQueueTests.bar", bar.label)
        bar.sync {
            XCTAssertEqual("DispatchQueueTests.bar", Dispatch.currentQueue.label)
        }
    }

    func testIsMainQueue() {
        XCTAssertTrue(Dispatch.mainQueue.isMainQueue)
        XCTAssertFalse(Dispatch.globalQueue.isMainQueue)
        XCTAssertFalse(foo.isMainQueue)
    }

    func testIsGlobalQueue() {
        XCTAssertFalse(Dispatch.mainQueue.isGlobalQueue)
        XCTAssertTrue(Dispatch.globalQueue.isGlobalQueue)
        XCTAssertFalse(foo.isGlobalQueue)
    }

    func testIsSystemQueue() {
        XCTAssertTrue(Dispatch.mainQueue.isSystemQueue)
        XCTAssertTrue(Dispatch.globalQueue.isSystemQueue)
        XCTAssertFalse(foo.isSystemQueue)
    }

    func testSync() {
        var ok = false
        Dispatch.globalQueue.sync { ok = true }
        XCTAssertTrue(ok)
    }

    func testAsync() {
        var ok = false
        foo.async { ok = true }
        foo.barrierSync { } // wait
        XCTAssertTrue(ok)
    }

}
