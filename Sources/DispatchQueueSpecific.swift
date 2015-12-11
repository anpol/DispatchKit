//
//  DispatchQueueSpecific.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2015 Andrei Polushin. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    public func getSpecific<T: AnyObject>(key: UnsafePointer<Void>) -> T? {
        let specific = dispatch_queue_get_specific(queue, key)
        return dk_takeUnretained(specific)
    }

    public func setSpecific<T: AnyObject>(key: UnsafePointer<Void>, _ specific: T?) {
        dispatch_queue_set_specific(queue, key, dk_passRetained(specific), dk_release)
    }
}

public extension DispatchCurrentQueue {
    public func getSpecific<T: AnyObject>(key: UnsafePointer<Void>) -> T? {
        let specific = dispatch_get_specific(key)
        return dk_takeUnretained(specific)
    }
}
