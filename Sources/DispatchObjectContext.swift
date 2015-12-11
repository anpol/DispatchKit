//
//  DispatchObjectContext.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2015 Andrei Polushin. All rights reserved.
//

import Foundation

public extension DispatchObject {
    func getContext<Cookie: DispatchCookie>() -> Cookie? {
        let context = dispatch_get_context(rawValue)
        if context == nil {
            return nil
        }
        return .Some(bridge(context))
    }

    func setContext<Cookie: DispatchCookie>(context: Cookie?) {
        let contextPtr = context.map { UnsafeMutablePointer<Void>(Unmanaged.passRetained($0).toOpaque()) } ?? nil
        dispatch_set_context(rawValue, contextPtr)
        dispatch_set_finalizer_f(rawValue, bridgeRelease)
    }
}
