//
//  Bridge.swift
//  DispatchKit
//
//  Copyright (c) 2015 Andrei Polushin. All rights reserved.
//

func bridge<T: AnyObject>(obj: T) -> UnsafePointer<Void> {
    return UnsafePointer(Unmanaged.passUnretained(obj).toOpaque())
}

func bridge<T: AnyObject>(ptr: UnsafePointer<Void>) -> T {
    return Unmanaged<T>.fromOpaque(COpaquePointer(ptr)).takeUnretainedValue()
}

func bridgeRetained<T: AnyObject>(obj: T) -> UnsafePointer<Void> {
    return UnsafePointer(Unmanaged.passRetained(obj).toOpaque())
}

func bridgeTransfer<T: AnyObject>(ptr: UnsafePointer<Void>) -> T {
    return Unmanaged<T>.fromOpaque(COpaquePointer(ptr)).takeRetainedValue()
}

func bridgeRelease(ptr: UnsafeMutablePointer<Void>) {
    Unmanaged<AnyObject>.fromOpaque(COpaquePointer(ptr)).release()
}
