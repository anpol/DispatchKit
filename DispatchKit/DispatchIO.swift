//
//  DispatchIO.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

public typealias DispatchIOType = DKDispatchIOType
public typealias DispatchIOCloseFlags = DKDispatchIOCloseFlags
public typealias DispatchIOIntervalFlags = DKDispatchIOIntervalFlags


public struct DispatchIO: DispatchObject {

    public let io: dispatch_io_t!

    public init(raw io: dispatch_io_t!) {
        self.io = io
    }

    public typealias CleanupHandler = (error: CInt) -> Void

    public init(_ type: DispatchIOType,
         fd: dispatch_fd_t,
         queue: DispatchQueue? = nil, cleanup: CleanupHandler! = nil) {

        self.io = dispatch_io_create(type.toRaw(), fd, queue?.queue, cleanup)
    }

    public init(_ type: DispatchIOType,
         path: String, oflag: CInt = O_RDONLY, mode: mode_t = 0o644,
         queue: DispatchQueue? = nil, cleanup: CleanupHandler! = nil) {

        self.io = dk_dispatch_io_create_with_path(type, path, oflag, mode, queue?.queue, cleanup)
    }

    public init(_ type: DispatchIOType,
         io: DispatchIO,
         queue: DispatchQueue? = nil, cleanup: CleanupHandler! = nil) {

        self.io = dispatch_io_create_with_io(type.toRaw(), io.io, queue?.queue, cleanup)
    }


    public func getContext() -> DispatchCookie? {
        return dk_dispatch_get_context(io)
    }

    public func setContext(context: DispatchCookie?) {
        dk_dispatch_set_context(io, context)
    }


    public static func read<T>(fd: dispatch_fd_t, length: Int = Int(SIZE_MAX),
                        queue: DispatchQueue, handler: (DispatchData<T>, Int) -> Void) {

        dispatch_read(fd, UInt(length), queue.queue) {
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


    public func read<T>(offset: off_t = 0, length: Int = Int(SIZE_MAX),
                 queue: DispatchQueue, handler: (Bool, DispatchData<T>, Int) -> Void) {

        dispatch_io_read(io, offset, UInt(length), queue.queue) {
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


    public func close(_ flags: DispatchIOCloseFlags = .Unspecified) {
        dispatch_io_close(io, flags.toRaw())
    }

    public var descriptior: dispatch_fd_t {
        return dispatch_io_get_descriptor(io)
    }

    public func setHighWater(highWater: Int) {
        dispatch_io_set_high_water(io, UInt(highWater))
    }

    public func setLowWater(lowWater: Int) {
        dispatch_io_set_low_water(io, UInt(lowWater))
    }

    public func setInterval(interval: Int64, flags: DispatchIOIntervalFlags = .Unspecified) {
        dispatch_io_set_interval(io, UInt64(interval), flags.toRaw())
    }
    
    public func barrier(block: dispatch_block_t) {
        dispatch_io_barrier(io, block)
    }

}
