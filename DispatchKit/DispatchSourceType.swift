//
//  DispatchSourceType.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

typealias DispatchSourceType = DKDispatchSourceType

extension DispatchSourceType {
    func toOpaque() -> dispatch_source_type_t {
        return dk_dispatch_source_type_to_opaque(self)
    }
}

typealias DispatchSourceMachSendFlags = DKDispatchSourceMachSendFlags
typealias DispatchSourceMemoryPressureFlags = DKDispatchSourceMemoryPressureFlags
typealias DispatchSourceProcFlags = DKDispatchSourceProcFlags
typealias DispatchSourceVnodeFlags = DKDispatchSourceVnodeFlags
typealias DispatchSourceTimerFlags = DKDispatchSourceTimerFlags
