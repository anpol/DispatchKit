//
//  DispatchQueueSpecific.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2015 Andrei Polushin. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    public func getSpecific<Cookie: DispatchCookie>(key: UnsafePointer<Void>) -> Cookie? {
        let specific = dispatch_get_specific(key)
        if specific == nil {
            return nil
        }
        
        return .Some(bridge(specific))
    }

    public func setSpecific<Cookie: DispatchCookie>(key: UnsafePointer<Void>, _ specific: Cookie?) {
        let retained = specific.map { UnsafeMutablePointer<Void>(bridgeRetained($0)) }
        dispatch_queue_set_specific(queue, key, retained ?? nil, bridgeRelease)
    }
}

public extension DispatchCurrentQueue {
    public func getSpecific<Cookie: DispatchCookie>(key: UnsafePointer<Void>) -> Cookie? {
        let specific: UnsafePointer<Void> = UnsafePointer(dispatch_get_specific(key))
        if specific == nil {
            return nil
        }
        return .Some(bridge(specific))
    }
}
