//
//  DispatchData.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

struct DispatchData<T: Integer>: DispatchObject {

    typealias Scale = DispatchDataScale<T>

    let data: dispatch_data_t!

    init(raw data: dispatch_data_t!) {
        self.data = data
    }

    // Copies the array data and manages it internally.
    init(_ array: [T]) {
        let size = Scale.toBytes(array.count)
        self.data = array.withUnsafePointerToElements { (p) in
            dispatch_data_create(p, size, nil, nil)
        }
    }

    // Consumes a buffer previosly allocated by UnsafePointer<T>.alloc(count)
    init(_ buffer: UnsafePointer<T>, _ count: Int, _ queue: dispatch_queue_t! = nil) {
        let size = Scale.toBytes(count)
        self.data = dispatch_data_create(buffer, size, queue) {
            buffer.dealloc(count)
        }
    }

    // The destructor is responsible to free the buffer.
    init(_ buffer: ConstUnsafePointer<T>, _ count: Int,
         _ queue: dispatch_queue_t!, destructor: dispatch_block_t!) {

        let size = Scale.toBytes(count)
        self.data = dispatch_data_create(buffer, size, queue, destructor)
    }

    func getContext() -> DispatchCookie {
        return dk_dispatch_get_context(data)
    }

    func setContext(context: DispatchCookie) {
        dk_dispatch_set_context(data, context)
    }

    var count: Int {
        return Scale.fromBytes(dispatch_data_get_size(data))
    }

    subscript(range: Range<Int>) -> DispatchData {
        let offset = Scale.toBytes(range.startIndex)
        let length = Scale.toBytes(range.endIndex - range.startIndex)
        return DispatchData(raw: dispatch_data_create_subrange(data, offset, length))
    }


    typealias Region = (data: DispatchData, offset: Int)

    func copyRegion(location: Int) -> Region {
        var offset: UInt = 0
        let region = dispatch_data_copy_region(data, Scale.toBytes(location), &offset)
        return (DispatchData(raw: region), Scale.fromBytes(offset))
    }


    typealias Buffer = (start: ConstUnsafePointer<T>, count: Int)

    func createMap() -> (owner: dispatch_data_t!, buffer: Buffer) {
        var buffer: ConstUnsafePointer<Void> = nil
        var size: UInt = 0
        let owner = dispatch_data_create_map(data, &buffer, &size)
        return (owner, (ConstUnsafePointer<T>(buffer), Scale.fromBytes(size)))
    }


    typealias Applier = (region: Region, buffer: Buffer) -> Bool

    func apply(applier: Applier) -> Bool {
        return dispatch_data_apply(data) {
            (region, offset, buffer, size) -> Bool in
            applier(region: (DispatchData<T>(raw: region), Scale.fromBytes(offset)),
                    buffer: (ConstUnsafePointer<T>(buffer), Scale.fromBytes(size)))
        }
    }

}


@infix func + <T>(a: DispatchData<T>, b: DispatchData<T>) -> DispatchData<T> {
    return DispatchData<T>(raw: dispatch_data_create_concat(a.data, b.data))
}
