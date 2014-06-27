//
//  DispatchIO.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

typealias DispatchIOType = DKDispatchIOType
typealias DispatchIOCloseFlags = DKDispatchIOCloseFlags
typealias DispatchIOIntervalFlags = DKDispatchIOIntervalFlags


struct DispatchIO: DispatchObject {

    let io: dispatch_io_t!

    init(raw io: dispatch_io_t!) {
        self.io = io
    }

    typealias CleanupHandler = (error: CInt) -> Void

    init(_ type: DispatchIOType,
         fd: dispatch_fd_t,
         queue: DispatchQueue? = nil, cleanup: CleanupHandler! = nil) {

        self.io = dispatch_io_create(type.toRaw(), fd, queue?.queue, cleanup)
    }

    init(_ type: DispatchIOType,
         path: String, oflag: CInt = O_RDONLY, mode: mode_t = 0o644,
         queue: DispatchQueue? = nil, cleanup: CleanupHandler! = nil) {

        self.io = dk_dispatch_io_create_with_path(type, path, oflag, mode, queue?.queue, cleanup)
    }

    init(_ type: DispatchIOType,
         io: DispatchIO,
         queue: DispatchQueue? = nil, cleanup: CleanupHandler! = nil) {

        self.io = dispatch_io_create_with_io(type.toRaw(), io.io, queue?.queue, cleanup)
    }


    func getContext() -> DispatchCookie {
        return dk_dispatch_get_context(io)
    }

    func setContext(context: DispatchCookie) {
        dk_dispatch_set_context(io, context)
    }


    static func read<T>(fd: dispatch_fd_t, length: Int = Int(SIZE_MAX),
                        queue: DispatchQueue, handler: (DispatchData<T>, Int) -> Void) {

        dispatch_read(fd, length.asUnsigned(), queue.queue) {
            (data, error) in
            handler(DispatchData<T>(raw: data), Int(error))
        }
    }

    static func write<T>(fd: dispatch_fd_t, data: DispatchData<T>,
                         queue: DispatchQueue, handler: (DispatchData<T>, Int) -> Void) {

        dispatch_write(fd, data.data, queue.queue) {
            (data, error) in
            handler(DispatchData<T>(raw: data), Int(error))
        }
    }


    func read<T>(offset: off_t = 0, length: Int = Int(SIZE_MAX),
                 queue: DispatchQueue, handler: (Bool, DispatchData<T>, Int) -> Void) {

        dispatch_io_read(io, offset, length.asUnsigned(), queue.queue) {
            (done, data, error) in
            handler(done, DispatchData<T>(raw: data), Int(error))
        }
    }

    func write<T>(offset: off_t = 0, data: DispatchData<T>,
                  queue: DispatchQueue, handler: (Bool, DispatchData<T>, Int) -> Void) {

        dispatch_io_write(io, offset, data.data, queue.queue) {
            (done, data, error) in
            handler(done, DispatchData<T>(raw: data), Int(error))
        }
    }


    func close(_ flags: DispatchIOCloseFlags = .Unspecified) {
        dispatch_io_close(io, flags.toRaw())
    }

    var descriptior: dispatch_fd_t {
        return dispatch_io_get_descriptor(io)
    }

    func setHighWater(highWater: Int) {
        dispatch_io_set_high_water(io, highWater.asUnsigned())
    }

    func setLowWater(lowWater: Int) {
        dispatch_io_set_low_water(io, lowWater.asUnsigned())
    }

    func setInterval(interval: Int64, flags: DispatchIOIntervalFlags = .Unspecified) {
        dispatch_io_set_interval(io, interval.asUnsigned(), flags.toRaw())
    }
    
    func barrier(block: dispatch_block_t) {
        dispatch_io_barrier(io, block)
    }

}
