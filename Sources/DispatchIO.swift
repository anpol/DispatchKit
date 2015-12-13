//
//  DispatchIO.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public struct DispatchIO: DispatchObject {

    public typealias RawValue = dispatch_io_t

    @available(*, unavailable, renamed="rawValue")
    public var io: RawValue {
        return rawValue
    }

    public let rawValue: RawValue

    @available(*, unavailable, renamed="DispatchIO(rawValue:)")
    public init(raw io: RawValue) {
        self.rawValue = io
    }

    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }

    public typealias CleanupHandler = (error: CInt) -> Void

    public init!(_ type: DispatchIOType,
         fd: dispatch_fd_t,
         queue: DispatchQueue? = nil, cleanup: CleanupHandler! = nil) {

        guard let rawValue = dispatch_io_create(type.rawValue, fd, queue?.rawValue, cleanup) else {
            return nil
        }

        self.rawValue = rawValue
    }

    public init!(_ type: DispatchIOType,
         path: String, oflag: CInt = O_RDONLY, mode: mode_t = 0o644,
         queue: DispatchQueue? = nil, cleanup: CleanupHandler! = nil) {

        guard let rawValue = dispatch_io_create_with_path(type.rawValue, path, oflag, mode, queue?.rawValue, cleanup) else {
            return nil
        }

        self.rawValue = rawValue
    }

    public init!(_ type: DispatchIOType,
         io: DispatchIO,
         queue: DispatchQueue? = nil, cleanup: CleanupHandler! = nil) {

        guard let rawValue = dispatch_io_create_with_io(type.rawValue, io.rawValue, queue?.rawValue, cleanup) else {
            return nil
        }

        self.rawValue = rawValue
    }


    public static func read<T>(fd: dispatch_fd_t, length: Int = Int.max,
                        queue: DispatchQueue, handler: (DispatchData<T>!, Int) -> Void) {

        dispatch_read(fd, length, queue.rawValue) {
            (data, error) in
            handler(DispatchData<T>(rawValue: data), Int(error))
        }
    }

    public static func write<T>(fd: dispatch_fd_t, data: DispatchData<T>,
                         queue: DispatchQueue, handler: (DispatchData<T>!, Int) -> Void) {

        dispatch_write(fd, data.rawValue, queue.rawValue) {
            (data, error) in
            handler(DispatchData<T>(rawValue: data), Int(error))
        }
    }


    public func read<T>(offset: off_t = 0, length: Int = Int.max,
                 queue: DispatchQueue, handler: (Bool, DispatchData<T>!, Int) -> Void) {

        dispatch_io_read(rawValue, offset, length, queue.rawValue) {
            (done, data, error) in
            handler(done, DispatchData<T>(rawValue: data), Int(error))
        }
    }

    public func write<T>(offset: off_t = 0, data: DispatchData<T>,
                  queue: DispatchQueue, handler: (Bool, DispatchData<T>!, Int) -> Void) {

        dispatch_io_write(rawValue, offset, data.rawValue, queue.rawValue) {
            (done, data, error) in
            handler(done, DispatchData<T>(rawValue: data), Int(error))
        }
    }


    public func close(flags: DispatchIOCloseFlags = .Unspecified) {
        dispatch_io_close(rawValue, flags.rawValue)
    }

    public var descriptior: dispatch_fd_t {
        return dispatch_io_get_descriptor(rawValue)
    }

    public func setHighWater(highWater: Int) {
        dispatch_io_set_high_water(rawValue, highWater)
    }

    public func setLowWater(lowWater: Int) {
        dispatch_io_set_low_water(rawValue, lowWater)
    }

    public func setInterval(interval: Int64, flags: DispatchIOIntervalFlags = .Unspecified) {
        dispatch_io_set_interval(rawValue, UInt64(interval), flags.rawValue)
    }

    public func barrier(block: dispatch_block_t) {
        dispatch_io_barrier(rawValue, block)
    }

}
