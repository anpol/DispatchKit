//
//  DispatchData.swift
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public struct DispatchData<T: IntegerType>: DispatchObject {

    typealias Scale = DispatchDataScale<T>

    public static var Empty: DispatchData {
        return DispatchData(raw: dispatch_data_empty)
    }

    public let data: dispatch_data_t
    
    public var rawValue: dispatch_object_t {
        return data
    }

    public init(raw data: dispatch_data_t) {
        self.data = data
    }

    /**
     * Copies the array's data and manages it internally.
     *
     * - parameter array: The array to be copied.
     */
    public init(_ array: [T]) {
        let size = Scale.toBytes(array.count)
        self.data = array.withUnsafeBufferPointer { (p) in
            dispatch_data_create(p.baseAddress, size, nil, nil)
        }
    }

    /**
     * Consumes a buffer previosly allocated by `UnsafeMutablePointer.alloc`_.
     *
     * - parameter buffer:
     * - parameter count:
     * - parameter queue: A queue on which to call `UnsafeMutablePointer.dealloc`_ for the buffer.
     */
    public init(_ buffer: UnsafeMutablePointer<T>, _ count: Int, _ queue: dispatch_queue_t! = nil) {
        let size = Scale.toBytes(count)
        self.data = dispatch_data_create(buffer, size, queue) {
            buffer.dealloc(count)
        }
    }

    // The destructor is responsible to free the buffer.
    public init(_ buffer: UnsafePointer<T>, _ count: Int,
         _ queue: dispatch_queue_t!, destructor: dispatch_block_t!) {

        let size = Scale.toBytes(count)
        self.data = dispatch_data_create(buffer, size, queue, destructor)
    }

    public var count: Int {
        return Scale.fromBytes(dispatch_data_get_size(data))
    }

    public subscript(range: Range<Int>) -> DispatchData {
        let offset = Scale.toBytes(range.startIndex)
        let length = Scale.toBytes(range.endIndex - range.startIndex)
        return DispatchData(raw: dispatch_data_create_subrange(data, offset, length))
    }


    public typealias Region = (data: DispatchData, offset: Int)

    public func copyRegion(location: Int) -> Region {
        var offset: Int = 0
        let region = dispatch_data_copy_region(data, Scale.toBytes(location), &offset)
        return (DispatchData(raw: region), Scale.fromBytes(offset))
    }


    public typealias Buffer = (start: UnsafePointer<T>, count: Int)

    public func createMap() -> (owner: dispatch_data_t!, buffer: Buffer) {
        var buffer: UnsafePointer<Void> = nil
        var size: Int = 0
        let owner = dispatch_data_create_map(data, &buffer, &size)
        return (owner, (UnsafePointer<T>(buffer), Scale.fromBytes(size)))
    }


    public typealias Applier = (region: Region, buffer: Buffer) -> Bool

    public func apply(applier: Applier) -> Bool {
        return dispatch_data_apply(data) {
            (region, offset, buffer, size) -> Bool in
            applier(region: (DispatchData<T>(raw: region), Scale.fromBytes(offset)),
                    buffer: (UnsafePointer<T>(buffer), Scale.fromBytes(size)))
        }
    }

}


public func + <T>(a: DispatchData<T>, b: DispatchData<T>) -> DispatchData<T> {
    return DispatchData<T>(raw: dispatch_data_create_concat(a.data, b.data))
}
