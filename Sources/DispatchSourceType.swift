//
//  DispatchSourceType.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public enum DKDispatchSourceType: UInt {
    
    case Unspecified = 0,
    DataAdd,
    DataOr,
    MachRecv,
    MachSend,
    Proc,
    Read,
    Signal,
    Timer,
    VNode,
    Write,
    MemoryPressure
    
}

public struct DKDispatchSourceMachSendFlags: OptionSetType {
    
    public typealias RawValue = dispatch_source_mach_send_flags_t
    public let rawValue: RawValue
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public static let Unspecified = DKDispatchSourceMachSendFlags(rawValue: 0)
    public static let Dead = DKDispatchSourceMachSendFlags(rawValue: DISPATCH_MACH_SEND_DEAD)
    
}

public struct DKDispatchSourceMemoryPressureFlags: OptionSetType {
    
    public typealias RawValue = dispatch_source_memorypressure_flags_t
    public let rawValue: RawValue
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public static let Unspecified = DKDispatchSourceMemoryPressureFlags(rawValue: 0)
    public static let Normal = DKDispatchSourceMemoryPressureFlags(rawValue: DISPATCH_MEMORYPRESSURE_NORMAL)
    public static let Warn = DKDispatchSourceMemoryPressureFlags(rawValue: DISPATCH_MEMORYPRESSURE_WARN)
    public static let Critical = DKDispatchSourceMemoryPressureFlags(rawValue: DISPATCH_MEMORYPRESSURE_CRITICAL)
    
}

public struct DKDispatchSourceProcFlags: OptionSetType {
    
    public typealias RawValue = dispatch_source_proc_flags_t
    public let rawValue: RawValue
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public static let Unspecified = DKDispatchSourceProcFlags(rawValue: 0)
    public static let Exit = DKDispatchSourceProcFlags(rawValue: DISPATCH_PROC_EXIT)
    public static let Fork = DKDispatchSourceProcFlags(rawValue: DISPATCH_PROC_FORK)
    public static let Exec = DKDispatchSourceProcFlags(rawValue: DISPATCH_PROC_EXEC)
    public static let Signal = DKDispatchSourceProcFlags(rawValue: DISPATCH_PROC_SIGNAL)
    
}

public struct DKDispatchSourceVnodeFlags: OptionSetType {
    
    public typealias RawValue = dispatch_source_vnode_flags_t
    public let rawValue: RawValue
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public static let Unspecified = DKDispatchSourceVnodeFlags(rawValue: 0)
    public static let Delete = DKDispatchSourceVnodeFlags(rawValue: DISPATCH_VNODE_DELETE)
    public static let Write = DKDispatchSourceVnodeFlags(rawValue: DISPATCH_VNODE_WRITE)
    public static let Extend = DKDispatchSourceVnodeFlags(rawValue: DISPATCH_VNODE_EXTEND)
    public static let Attrib = DKDispatchSourceVnodeFlags(rawValue: DISPATCH_VNODE_ATTRIB)
    public static let Link = DKDispatchSourceVnodeFlags(rawValue: DISPATCH_VNODE_LINK)
    public static let Rename = DKDispatchSourceVnodeFlags(rawValue: DISPATCH_VNODE_RENAME)
    public static let Revoke = DKDispatchSourceVnodeFlags(rawValue: DISPATCH_VNODE_REVOKE)
    
}

public struct DKDispatchSourceTimerFlags: OptionSetType {
    
    public typealias RawValue = dispatch_source_timer_flags_t
    public let rawValue: RawValue
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public static let Unspecified = DKDispatchSourceTimerFlags(rawValue: 0)
    public static let Strict = DKDispatchSourceTimerFlags(rawValue: DISPATCH_TIMER_STRICT)
    
}

public typealias DispatchSourceType = DKDispatchSourceType

extension DispatchSourceType {
    
    public func toOpaque() -> dispatch_source_type_t {
        switch (self) {
        case .Unspecified:
            return nil
        case .DataAdd:
            return DISPATCH_SOURCE_TYPE_DATA_ADD
        case .DataOr:
            return DISPATCH_SOURCE_TYPE_DATA_OR
        case .MachRecv:
            return DISPATCH_SOURCE_TYPE_MACH_RECV
        case .MachSend:
            return DISPATCH_SOURCE_TYPE_MACH_SEND
        case .Proc:
            return DISPATCH_SOURCE_TYPE_PROC
        case .Read:
            return DISPATCH_SOURCE_TYPE_READ
        case .Signal:
            return DISPATCH_SOURCE_TYPE_SIGNAL
        case .Timer:
            return DISPATCH_SOURCE_TYPE_TIMER
        case .VNode:
            return DISPATCH_SOURCE_TYPE_VNODE
        case .Write:
            return DISPATCH_SOURCE_TYPE_WRITE
        case .MemoryPressure:
            return DISPATCH_SOURCE_TYPE_MEMORYPRESSURE
        }
    }
    
}

public typealias DispatchSourceMachSendFlags = DKDispatchSourceMachSendFlags
public typealias DispatchSourceMemoryPressureFlags = DKDispatchSourceMemoryPressureFlags
public typealias DispatchSourceProcFlags = DKDispatchSourceProcFlags
public typealias DispatchSourceVnodeFlags = DKDispatchSourceVnodeFlags
public typealias DispatchSourceTimerFlags = DKDispatchSourceTimerFlags
