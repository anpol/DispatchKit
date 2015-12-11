//
//  DispatchQueueSpecificTests.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2015 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

class DispatchQueueSpecificTests : XCTestCase {
    var foo: DispatchQueue!
    var bar: DispatchQueue!

    override func setUp() {
        foo = DispatchQueue("DispatchQueueTests.foo")
        bar = DispatchQueue("DispatchQueueTests.bar")
        foo.setTargetQueue(bar)
    }

    override func tearDown() {
        foo = nil
        bar = nil
    }

    class TestSpecific {
        let name: String
        init(_ name: String) {
            self.name = name
        }
    }

    func testQueueSpecific() {
        struct Keys {
            static var Foo: Int8 = 0
            static var Bar: Int8 = 0
            static var Baz: Int8 = 0
        }

        foo.setSpecific(&Keys.Foo, TestSpecific("Foo"))
        bar.setSpecific(&Keys.Bar, TestSpecific("Bar"))

        foo.sync {
            let fooTest: TestSpecific? = Dispatch.currentQueue.getSpecific(&Keys.Foo)
            let barTest: TestSpecific? = Dispatch.currentQueue.getSpecific(&Keys.Bar)
            let bazTest: TestSpecific? = Dispatch.currentQueue.getSpecific(&Keys.Baz)
            XCTAssertEqual("Foo", fooTest?.name)
            XCTAssertEqual("Bar", barTest?.name)
            XCTAssertNil(bazTest)
        }

        bar.sync {
            let fooTest: TestSpecific? = Dispatch.currentQueue.getSpecific(&Keys.Foo)
            let barTest: TestSpecific? = Dispatch.currentQueue.getSpecific(&Keys.Bar)
            let bazTest: TestSpecific? = Dispatch.currentQueue.getSpecific(&Keys.Baz)
            XCTAssertNil(fooTest)
            XCTAssertEqual("Bar", barTest?.name)
            XCTAssertNil(bazTest)
        }
    }
}
