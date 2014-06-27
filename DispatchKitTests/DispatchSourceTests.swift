//
//  DispatchSourceTests.swift
//  DispatchKit
//
//  Created by Andrei Polushin on 07.07.14.
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import DispatchKit
import XCTest

class DispatchSourceTests: XCTestCase {

    func testDispatchSourceType() {
        XCTAssertEqual(COpaquePointer.null(), DispatchSourceType.Unspecified.toOpaque())
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

    func testDispatchSourceMachSendFlags() {
        XCTAssertEqual(0, DispatchSourceMachSendFlags.Unspecified.toRaw())
        XCTAssertEqual(DISPATCH_MACH_SEND_DEAD, DispatchSourceMachSendFlags.Dead.toRaw())
    }

    func testDispatchSourceMemoryPressureFlagsFlags() {
        XCTAssertEqual(0, DispatchSourceMemoryPressureFlags.Unspecified.toRaw())
        XCTAssertEqual(DISPATCH_MEMORYPRESSURE_NORMAL, DispatchSourceMemoryPressureFlags.Normal.toRaw())
        XCTAssertEqual(DISPATCH_MEMORYPRESSURE_WARN, DispatchSourceMemoryPressureFlags.Warn.toRaw())
        XCTAssertEqual(DISPATCH_MEMORYPRESSURE_CRITICAL, DispatchSourceMemoryPressureFlags.Critical.toRaw())
    }

    func testDispatchSourceProcFlagsFlags() {
        XCTAssertEqual(0, DispatchSourceProcFlags.Unspecified.toRaw())
        XCTAssertEqual(DISPATCH_PROC_EXIT, DispatchSourceProcFlags.Exit.toRaw())
        XCTAssertEqual(DISPATCH_PROC_FORK, DispatchSourceProcFlags.Fork.toRaw())
        XCTAssertEqual(DISPATCH_PROC_EXEC, DispatchSourceProcFlags.Exec.toRaw())
        XCTAssertEqual(DISPATCH_PROC_SIGNAL, DispatchSourceProcFlags.Signal.toRaw())
    }

    func testDispatchSourceVnodeFlagsFlags() {
        XCTAssertEqual(0, DispatchSourceVnodeFlags.Unspecified.toRaw())
        XCTAssertEqual(DISPATCH_VNODE_DELETE, DispatchSourceVnodeFlags.Delete.toRaw())
        XCTAssertEqual(DISPATCH_VNODE_WRITE, DispatchSourceVnodeFlags.Write.toRaw())
        XCTAssertEqual(DISPATCH_VNODE_EXTEND, DispatchSourceVnodeFlags.Extend.toRaw())
        XCTAssertEqual(DISPATCH_VNODE_ATTRIB, DispatchSourceVnodeFlags.Attrib.toRaw())
        XCTAssertEqual(DISPATCH_VNODE_LINK, DispatchSourceVnodeFlags.Link.toRaw())
        XCTAssertEqual(DISPATCH_VNODE_RENAME, DispatchSourceVnodeFlags.Rename.toRaw())
        XCTAssertEqual(DISPATCH_VNODE_REVOKE, DispatchSourceVnodeFlags.Revoke.toRaw())
    }

    func testDispatchSourceTimerFlagsFlags() {
        XCTAssertEqual(0, DispatchSourceTimerFlags.Unspecified.toRaw())
        XCTAssertEqual(DISPATCH_TIMER_STRICT, DispatchSourceTimerFlags.Strict.toRaw())
    }

}
