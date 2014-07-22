//
//  DispatchSourceType.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

public typealias DispatchSourceType = DKDispatchSourceType

extension DispatchSourceType {
    public func toOpaque() -> dispatch_source_type_t {
        return dk_dispatch_source_type_to_opaque(self)
    }
}

public typealias DispatchSourceMachSendFlags = DKDispatchSourceMachSendFlags
public typealias DispatchSourceMemoryPressureFlags = DKDispatchSourceMemoryPressureFlags
public typealias DispatchSourceProcFlags = DKDispatchSourceProcFlags
public typealias DispatchSourceVnodeFlags = DKDispatchSourceVnodeFlags
public typealias DispatchSourceTimerFlags = DKDispatchSourceTimerFlags
