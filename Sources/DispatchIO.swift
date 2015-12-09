//
//  DispatchIO.swift
//  DispatchKit
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


public struct DispatchIO: DispatchObject {

    public let io: dispatch_io_t!

    public var rawValue: dispatch_object_t! {
        return io
    }

    public init(raw io: dispatch_io_t!) {
        self.io = io
    }

    public typealias CleanupHandler = (error: CInt) -> Void

    public init(_ type: DispatchIOType,
         fd: dispatch_fd_t,
         queue: DispatchQueue? = nil, cleanup: CleanupHandler! = nil) {

        self.io = dispatch_io_create(type.rawValue, fd, queue?.queue, cleanup)
    }

    public init(_ type: DispatchIOType,
         path: String, oflag: CInt = O_RDONLY, mode: mode_t = 0o644,
         queue: DispatchQueue? = nil, cleanup: CleanupHandler! = nil) {

        self.io = dispatch_io_create_with_path(type.rawValue, path, oflag, mode, queue?.queue, cleanup)
    }

    public init(_ type: DispatchIOType,
         io: DispatchIO,
         queue: DispatchQueue? = nil, cleanup: CleanupHandler! = nil) {

        self.io = dispatch_io_create_with_io(type.rawValue, io.io, queue?.queue, cleanup)
    }


    public static func read<T>(fd: dispatch_fd_t, length: Int = Int.max,
                        queue: DispatchQueue, handler: (DispatchData<T>, Int) -> Void) {

        dispatch_read(fd, length, queue.queue) {
            (data, error) in
            handler(DispatchData<T>(raw: data), Int(error))
        }
    }

    public static func write<T>(fd: dispatch_fd_t, data: DispatchData<T>,
                         queue: DispatchQueue, handler: (DispatchData<T>, Int) -> Void) {

        dispatch_write(fd, data.data, queue.queue) {
            (data, error) in
            handler(DispatchData<T>(raw: data), Int(error))
        }
    }


    public func read<T>(offset: off_t = 0, length: Int = Int.max,
                 queue: DispatchQueue, handler: (Bool, DispatchData<T>, Int) -> Void) {

        dispatch_io_read(io, offset, length, queue.queue) {
            (done, data, error) in
            handler(done, DispatchData<T>(raw: data), Int(error))
        }
    }

    public func write<T>(offset: off_t = 0, data: DispatchData<T>,
                  queue: DispatchQueue, handler: (Bool, DispatchData<T>, Int) -> Void) {

        dispatch_io_write(io, offset, data.data, queue.queue) {
            (done, data, error) in
            handler(done, DispatchData<T>(raw: data), Int(error))
        }
    }


    public func close(flags: DispatchIOCloseFlags = .Unspecified) {
        dispatch_io_close(io, flags.rawValue)
    }

    public var descriptior: dispatch_fd_t {
        return dispatch_io_get_descriptor(io)
    }

    public func setHighWater(highWater: Int) {
        dispatch_io_set_high_water(io, highWater)
    }

    public func setLowWater(lowWater: Int) {
        dispatch_io_set_low_water(io, lowWater)
    }

    public func setInterval(interval: Int64, flags: DispatchIOIntervalFlags = .Unspecified) {
        dispatch_io_set_interval(io, UInt64(interval), flags.rawValue)
    }
    
    public func barrier(block: dispatch_block_t) {
        dispatch_io_barrier(io, block)
    }

}
