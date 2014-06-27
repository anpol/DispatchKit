//
//  DispatchQueueTests.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

class DispatchQueueTests: XCTestCase {

    var customQueue = DispatchQueue()

    func testQueuePriority() {
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_HIGH, DispatchQueuePriority.High.toRaw())
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_DEFAULT, DispatchQueuePriority.Default.toRaw())
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_LOW, DispatchQueuePriority.Low.toRaw())
        XCTAssertEqual(DISPATCH_QUEUE_PRIORITY_BACKGROUND, DispatchQueuePriority.Background.toRaw())
    }

    func testLabel() {
        println("mainQueue: \(Dispatch.mainQueue.label)")
        println("globalQueue: \(Dispatch.globalQueue.label)")
        println("currentQueue: \(Dispatch.currentQueue.label)")
        println("customQueue: \(customQueue.label)")
        customQueue.sync {
            println("customQueue: \(Dispatch.currentQueue.label)")
        }
    }

    func testIsMainQueue() {
        XCTAssertTrue(Dispatch.mainQueue.isMainQueue)
        XCTAssertFalse(Dispatch.globalQueue.isMainQueue)
        XCTAssertFalse(customQueue.isMainQueue)
    }

    func testIsGlobalQueue() {
        XCTAssertFalse(Dispatch.mainQueue.isGlobalQueue)
        XCTAssertTrue(Dispatch.globalQueue.isGlobalQueue)
        XCTAssertFalse(customQueue.isGlobalQueue)
    }

    func testIsSystemQueue() {
        XCTAssertTrue(Dispatch.mainQueue.isSystemQueue)
        XCTAssertTrue(Dispatch.globalQueue.isSystemQueue)
        XCTAssertFalse(customQueue.isSystemQueue)
    }

    func testSync() {
        var ok = false
        Dispatch.globalQueue.sync { ok = true }
        XCTAssertTrue(ok)
    }

    func testAsync() {
        var ok = false
        customQueue.async { ok = true }
        customQueue.barrierSync { } // wait
        XCTAssertTrue(ok)
    }

}
