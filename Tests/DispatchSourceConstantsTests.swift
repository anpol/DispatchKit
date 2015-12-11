//
//  DispatchSourceConstantsTests.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

class DispatchSourceConstantsTests: XCTestCase {

    func testSourceType() {
        XCTAssert(DispatchSourceType.Unspecified.toOpaque() == nil)
        XCTAssertEqual(DISPATCH_SOURCE_TYPE_DATA_ADD, DispatchSourceType.DataAdd.toOpaque())
        XCTAssertEqual(DISPATCH_SOURCE_TYPE_DATA_OR, DispatchSourceType.DataOr.toOpaque())
        XCTAssertEqual(DISPATCH_SOURCE_TYPE_MACH_RECV, DispatchSourceType.MachRecv.toOpaque())
        XCTAssertEqual(DISPATCH_SOURCE_TYPE_MACH_SEND, DispatchSourceType.MachSend.toOpaque())
        XCTAssertEqual(DISPATCH_SOURCE_TYPE_PROC, DispatchSourceType.Proc.toOpaque())
        XCTAssertEqual(DISPATCH_SOURCE_TYPE_READ, DispatchSourceType.Read.toOpaque())
        XCTAssertEqual(DISPATCH_SOURCE_TYPE_SIGNAL, DispatchSourceType.Signal.toOpaque())
        XCTAssertEqual(DISPATCH_SOURCE_TYPE_TIMER, DispatchSourceType.Timer.toOpaque())
        XCTAssertEqual(DISPATCH_SOURCE_TYPE_VNODE, DispatchSourceType.VNode.toOpaque())
        XCTAssertEqual(DISPATCH_SOURCE_TYPE_WRITE, DispatchSourceType.Write.toOpaque())
        XCTAssertEqual(DISPATCH_SOURCE_TYPE_MEMORYPRESSURE, DispatchSourceType.MemoryPressure.toOpaque())
    }

    func testSourceMachSendFlags() {
        XCTAssertEqual(0, Int(DispatchSourceMachSendFlags.Unspecified.rawValue))
        XCTAssertEqual(DISPATCH_MACH_SEND_DEAD, DispatchSourceMachSendFlags.Dead.rawValue)
    }

    func testSourceMemoryPressureFlags() {
        XCTAssertEqual(0, Int(DispatchSourceMemoryPressureFlags.Unspecified.rawValue))
        XCTAssertEqual(DISPATCH_MEMORYPRESSURE_NORMAL, DispatchSourceMemoryPressureFlags.Normal.rawValue)
        XCTAssertEqual(DISPATCH_MEMORYPRESSURE_WARN, DispatchSourceMemoryPressureFlags.Warn.rawValue)
        XCTAssertEqual(DISPATCH_MEMORYPRESSURE_CRITICAL, DispatchSourceMemoryPressureFlags.Critical.rawValue)
    }

    func testSourceProcFlags() {
        XCTAssertEqual(0, Int(DispatchSourceProcFlags.Unspecified.rawValue))
        XCTAssertEqual(DISPATCH_PROC_EXIT, DispatchSourceProcFlags.Exit.rawValue)
        XCTAssertEqual(DISPATCH_PROC_FORK, DispatchSourceProcFlags.Fork.rawValue)
        XCTAssertEqual(DISPATCH_PROC_EXEC, DispatchSourceProcFlags.Exec.rawValue)
        XCTAssertEqual(DISPATCH_PROC_SIGNAL, DispatchSourceProcFlags.Signal.rawValue)
    }

    func testSourceVnodeFlags() {
        XCTAssertEqual(0, Int(DispatchSourceVnodeFlags.Unspecified.rawValue))
        XCTAssertEqual(DISPATCH_VNODE_DELETE, DispatchSourceVnodeFlags.Delete.rawValue)
        XCTAssertEqual(DISPATCH_VNODE_WRITE, DispatchSourceVnodeFlags.Write.rawValue)
        XCTAssertEqual(DISPATCH_VNODE_EXTEND, DispatchSourceVnodeFlags.Extend.rawValue)
        XCTAssertEqual(DISPATCH_VNODE_ATTRIB, DispatchSourceVnodeFlags.Attrib.rawValue)
        XCTAssertEqual(DISPATCH_VNODE_LINK, DispatchSourceVnodeFlags.Link.rawValue)
        XCTAssertEqual(DISPATCH_VNODE_RENAME, DispatchSourceVnodeFlags.Rename.rawValue)
        XCTAssertEqual(DISPATCH_VNODE_REVOKE, DispatchSourceVnodeFlags.Revoke.rawValue)
    }

    func testSourceTimerFlags() {
        XCTAssertEqual(0, Int(DispatchSourceTimerFlags.Unspecified.rawValue))
        XCTAssertEqual(DISPATCH_TIMER_STRICT, DispatchSourceTimerFlags.Strict.rawValue)
    }

}
