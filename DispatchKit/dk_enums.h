//
//  dk_enums.h
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>


typedef NS_ENUM(NSUInteger, DKDispatchQOSClass) {
  #ifndef QOS_MIN_RELATIVE_PRIORITY
    DKDispatchQOSClassUnspecified = 0,
  #else
    DKDispatchQOSClassUnspecified = QOS_CLASS_UNSPECIFIED,
    DKDispatchQOSClassUserInteractive = QOS_CLASS_USER_INTERACTIVE,
    DKDispatchQOSClassUserInitiated = QOS_CLASS_USER_INITIATED,
    DKDispatchQOSClassDefault = QOS_CLASS_DEFAULT,
    DKDispatchQOSClassUtility = QOS_CLASS_UTILITY,
    DKDispatchQOSClassBackground = QOS_CLASS_BACKGROUND,
  #endif
};


typedef NS_ENUM(dispatch_queue_priority_t, DKDispatchQueuePriority) {
    DKDispatchQueuePriorityHigh = DISPATCH_QUEUE_PRIORITY_HIGH,
    DKDispatchQueuePriorityDefault = DISPATCH_QUEUE_PRIORITY_DEFAULT,
    DKDispatchQueuePriorityLow = DISPATCH_QUEUE_PRIORITY_LOW,
    DKDispatchQueuePriorityBackground = DISPATCH_QUEUE_PRIORITY_BACKGROUND,
};


typedef NS_ENUM(dispatch_io_type_t, DKDispatchIOType) {
    DKDispatchIOTypeStream = DISPATCH_IO_STREAM,
    DKDispatchIOTypeRandom = DISPATCH_IO_RANDOM,
};


typedef NS_OPTIONS(dispatch_io_close_flags_t, DKDispatchIOCloseFlags) {
    DKDispatchIOCloseFlagUnspecified = 0,
    DKDispatchIOCloseFlagStop = DISPATCH_IO_STOP,
};


typedef NS_OPTIONS(dispatch_io_interval_flags_t, DKDispatchIOIntervalFlags) {
    DKDispatchIOIntervalFlagUnspecified = 0,
    DKDispatchIOIntervalFlagStrict = DISPATCH_IO_STRICT_INTERVAL,
};


typedef NS_ENUM(NSUInteger, DKDispatchSourceType) {
    DKDispatchSourceTypeUnspecified = 0,
    DKDispatchSourceTypeDataAdd,
    DKDispatchSourceTypeDataOr,
    DKDispatchSourceTypeMachRecv,
    DKDispatchSourceTypeMachSend,
    DKDispatchSourceTypeProc,
    DKDispatchSourceTypeRead,
    DKDispatchSourceTypeSignal,
    DKDispatchSourceTypeTimer,
    DKDispatchSourceTypeVNode,
    DKDispatchSourceTypeWrite,
    DKDispatchSourceTypeMemoryPressure,
};


typedef NS_OPTIONS(dispatch_source_mach_send_flags_t, DKDispatchSourceMachSendFlags) {
    DKDispatchSourceMachSendUnspecified = 0,
    DKDispatchSourceMachSendDead = DISPATCH_MACH_SEND_DEAD,
};


typedef NS_OPTIONS(dispatch_source_memorypressure_flags_t, DKDispatchSourceMemoryPressureFlags) {
    DKDispatchSourceMemoryPressureUnspecified = 0,
    DKDispatchSourceMemoryPressureNormal = DISPATCH_MEMORYPRESSURE_NORMAL,
    DKDispatchSourceMemoryPressureWarn = DISPATCH_MEMORYPRESSURE_WARN,
    DKDispatchSourceMemoryPressureCritical = DISPATCH_MEMORYPRESSURE_CRITICAL,
};


typedef NS_OPTIONS(dispatch_source_proc_flags_t, DKDispatchSourceProcFlags) {
    DKDispatchSourceProcUnspecified = 0,
    DKDispatchSourceProcExit = DISPATCH_PROC_EXIT,
    DKDispatchSourceProcFork = DISPATCH_PROC_FORK,
    DKDispatchSourceProcExec = DISPATCH_PROC_EXEC,
    DKDispatchSourceProcSignal = DISPATCH_PROC_SIGNAL,
};


typedef NS_OPTIONS(dispatch_source_vnode_flags_t, DKDispatchSourceVnodeFlags) {
    DKDispatchSourceVnodeUnspecified = 0,
    DKDispatchSourceVnodeDelete = DISPATCH_VNODE_DELETE,
    DKDispatchSourceVnodeWrite = DISPATCH_VNODE_WRITE,
    DKDispatchSourceVnodeExtend = DISPATCH_VNODE_EXTEND,
    DKDispatchSourceVnodeAttrib = DISPATCH_VNODE_ATTRIB,
    DKDispatchSourceVnodeLink = DISPATCH_VNODE_LINK,
    DKDispatchSourceVnodeRename = DISPATCH_VNODE_RENAME,
    DKDispatchSourceVnodeRevoke = DISPATCH_VNODE_REVOKE,
};


typedef NS_OPTIONS(dispatch_source_timer_flags_t, DKDispatchSourceTimerFlags) {
    DKDispatchSourceTimerUnspecified = 0,
    DKDispatchSourceTimerStrict = DISPATCH_TIMER_STRICT,
};

