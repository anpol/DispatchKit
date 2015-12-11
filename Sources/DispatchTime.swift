//
//  DispatchTime.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

import Foundation

public enum DispatchTime {

    case Forever

    case Now
    case NowDelta(Int64)

    case WallClock(UnsafePointer<timespec>)
    case WallClockDelta(UnsafePointer<timespec>, Int64)

    public var rawValue: dispatch_time_t {
        switch self {
        case .Forever:
            return DISPATCH_TIME_FOREVER
        case .Now:
            return DISPATCH_TIME_NOW
        case let .NowDelta(nsec):
            return dispatch_time(DISPATCH_TIME_NOW, nsec)
        case let .WallClock(timespec):
            return dispatch_walltime(timespec, 0)
        case let .WallClockDelta(timespec, nsec):
            return dispatch_walltime(timespec, nsec)
        }
    }

}


public enum DispatchTimeDelta {

    case Nanoseconds(Int64)
    case Microseconds(Int64)
    case Milliseconds(Int64)
    case Seconds(Int64)
    case Minutes(Int)
    case Hours(Int)
    case Days(Int)
    case Weeks(Int)

    public var rawValue: UInt64 {
        var t: UInt64
        switch self {
        case let .Nanoseconds(nsec):  t = UInt64(nsec)
        case let .Microseconds(usec): t = UInt64(usec) * NSEC_PER_USEC
        case let .Milliseconds(msec): t = UInt64(msec) * NSEC_PER_MSEC
        case let .Seconds(sec):       t = UInt64(sec) * NSEC_PER_SEC
        case let .Minutes(mins):      t = UInt64(mins * 60) * NSEC_PER_SEC
        case let .Hours(hrs):         t = UInt64(hrs * 3600) * NSEC_PER_SEC
        case let .Days(days):         t = UInt64(days * 3600 * 24) * NSEC_PER_SEC
        case let .Weeks(wks):         t = UInt64(wks * 3600 * 24 * 7) * NSEC_PER_SEC
        }
        return t
    }

    public func toNanoseconds() -> Int64 {
        return Int64(rawValue)
    }

}


public func +(time: DispatchTime, delta: DispatchTimeDelta) -> DispatchTime {
    switch time {
    case .Forever:
        return time
    case .Now:
        return .NowDelta(delta.toNanoseconds())
    case let .NowDelta(nsec):
        return .NowDelta(nsec + delta.toNanoseconds())
    case let .WallClock(timespec):
        return .WallClockDelta(timespec, delta.toNanoseconds())
    case let .WallClockDelta(timespec, nsec):
        return .WallClockDelta(timespec, nsec + delta.toNanoseconds())
    }
}

public func +(delta: DispatchTimeDelta, time: DispatchTime) -> DispatchTime {
    return time + delta
}

public func +(delta1: DispatchTimeDelta, delta2: DispatchTimeDelta) -> DispatchTimeDelta {
    return .Nanoseconds(delta1.toNanoseconds() + delta2.toNanoseconds())
}
