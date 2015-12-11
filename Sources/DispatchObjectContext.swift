//
//  DispatchObjectContext.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2015 Andrei Polushin. All rights reserved.
//

import Foundation

func dk_takeUnretained<T: AnyObject>(ptr: UnsafeMutablePointer<Void>) -> T? {
    if ptr != nil {
        return Unmanaged<T>.fromOpaque(COpaquePointer(ptr)).takeUnretainedValue()
    }
    return nil
}

func dk_passRetained<T: AnyObject>(obj: T?) -> UnsafeMutablePointer<Void> {
    if let obj = obj {
        return UnsafeMutablePointer(Unmanaged.passRetained(obj).toOpaque())
    }
    return nil
}

func dk_release(ptr: UnsafeMutablePointer<Void>) {
    Unmanaged<AnyObject>.fromOpaque(COpaquePointer(ptr)).release()
}

public extension DispatchObject {
    func getContext<T: AnyObject>() -> T? {
        let context = dispatch_get_context(rawValue)
        return dk_takeUnretained(context)
    }

    func setContext<T: AnyObject>(context: T?) {
        dispatch_set_context(rawValue, dk_passRetained(context))
        dispatch_set_finalizer_f(rawValue, dk_release)
    }
}
