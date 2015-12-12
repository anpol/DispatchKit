//
//  DispatchIOConstants.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public enum DKDispatchIOType {
    
    case Stream,
    Random
    
    public var rawValue: dispatch_io_type_t {
        switch self {
        case .Stream:
            return DISPATCH_IO_STREAM
        case .Random:
            return DISPATCH_IO_RANDOM
        }
    }
    
}

public struct DKDispatchIOCloseFlags: OptionSetType {
    
    public typealias RawValue = dispatch_io_close_flags_t
    public let rawValue: RawValue
    public init(rawValue: dispatch_io_close_flags_t) {
        self.rawValue = rawValue
    }
    
    public static let Unspecified = DKDispatchIOCloseFlags(rawValue: 0)
    public static let Stop = DKDispatchIOCloseFlags(rawValue: DISPATCH_IO_STOP)
    
}



public struct DKDispatchIOIntervalFlags: OptionSetType {
    
    public typealias RawValue = dispatch_io_interval_flags_t
    public let rawValue: RawValue
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public static let Unspecified = DKDispatchIOIntervalFlags(rawValue: 0)
    public static let Strict = DKDispatchIOIntervalFlags(rawValue: DISPATCH_IO_STRICT_INTERVAL)
    
}

public typealias DispatchIOType = DKDispatchIOType
public typealias DispatchIOCloseFlags = DKDispatchIOCloseFlags
public typealias DispatchIOIntervalFlags = DKDispatchIOIntervalFlags
