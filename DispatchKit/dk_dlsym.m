//
//  dk_dlsym.m
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

#import "dk_dlsym.h"
#import <dlfcn.h>

static void
dk_dispatch_cookie_release(void *cookie)
{
    CFRelease(cookie);
}

id<DispatchCookie>
dk_dispatch_get_context(dispatch_object_t object)
{
    return (__bridge_transfer id<DispatchCookie>)dispatch_get_context(object);
}

void
dk_dispatch_set_context(dispatch_object_t object, id<DispatchCookie> cookie)
{
    dispatch_set_context(object, (__bridge_retained void *)cookie);
    dispatch_set_finalizer_f(object, dk_dispatch_cookie_release);
}

id<DispatchCookie>
dk_dispatch_queue_get_specific(dispatch_queue_t queue, const void *key)
{
    return (__bridge_transfer id<DispatchCookie>)dispatch_queue_get_specific(queue, key);
}

void
dk_dispatch_queue_set_specific(dispatch_queue_t queue, const void *key, id<DispatchCookie> cookie)
{
    dispatch_queue_set_specific(queue, key,
                                (__bridge_retained void *)cookie,
                                dk_dispatch_cookie_release);
}

id<DispatchCookie>
dk_dispatch_get_specific(const void *key)
{
    return (__bridge_transfer id<DispatchCookie>)dispatch_get_specific(key);
}


dispatch_queue_t
dk_dispatch_get_main_queue(void)
{
    return dispatch_get_main_queue();
}


static void *
dk_dispatch_dlsym(const char *name)
{
    // Handle is never closed, closing it would invalidate dlsym results.
    static void *handle;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Dl_info dli;
        if (dladdr(&dispatch_main, &dli)) {
            handle = dlopen(dli.dli_fname, RTLD_LAZY | RTLD_GLOBAL);
        }
    });

    return handle ? dlsym(handle, name) : NULL;
}

typedef
DISPATCH_WARN_RESULT DISPATCH_PURE DISPATCH_NOTHROW
dispatch_queue_attr_t
(*dk_dispatch_queue_attr_make_with_qos_class_t)(dispatch_queue_attr_t attr,
                                                DKDispatchQOSClass qos_class,
                                                int relative_priority);

static dk_dispatch_queue_attr_make_with_qos_class_t
dk_dispatch_queue_attr_make_with_qos_class_dlsym()
{
    static dk_dispatch_queue_attr_make_with_qos_class_t func;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        func = dk_dispatch_dlsym("dispatch_queue_attr_make_with_qos_class");
    });

    return func;
}

BOOL
dk_dispatch_has_qos_class()
{
    return !!dk_dispatch_queue_attr_make_with_qos_class_dlsym();
}

dispatch_queue_t
dk_dispatch_queue_create_with_qos_class(NSString *label, dispatch_queue_attr_t attr,
                                        DKDispatchQOSClass qos_class,
                                        NSInteger relative_priority)
{
  #ifdef QOS_MIN_RELATIVE_PRIORITY
    NSCAssert(QOS_MIN_RELATIVE_PRIORITY <= relative_priority && relative_priority <= 0,
              @"Invalid parameter: relative_priority");

    if (qos_class != DKDispatchQOSClassUnspecified) {
        dk_dispatch_queue_attr_make_with_qos_class_t queue_attr_make_with_qos_class =
        dk_dispatch_queue_attr_make_with_qos_class_dlsym();

        dispatch_queue_t queue = NULL;
        if (queue_attr_make_with_qos_class) {
            // iOS 8 and later: apply QOS class
            attr = queue_attr_make_with_qos_class(attr, qos_class, (int)relative_priority);
            if (attr) {
                queue = dispatch_queue_create(label.UTF8String, attr);
            }
        } else {
            queue = dispatch_queue_create(label.UTF8String, attr);
            
            // iOS 7 and earlier: simulate QOS class by applying a target queue.
            if (queue) {
                dispatch_queue_priority_t priority = dk_dispatch_qos_class_to_priority(qos_class);
                dispatch_set_target_queue(queue, dispatch_get_global_queue(priority, 0));
            }
        }
        return queue;
    }
  #endif
    return dispatch_queue_create(label.UTF8String, attr);
}

// Returns best possible, yet approximate mapping.
DKDispatchQueuePriority
dk_dispatch_qos_class_to_priority(DKDispatchQOSClass qos_class)
{
  #ifdef QOS_MIN_RELATIVE_PRIORITY
    switch ((dispatch_qos_class_t)qos_class) {
    case QOS_CLASS_USER_INTERACTIVE: /* fallthrough */
    case QOS_CLASS_USER_INITIATED:   return DKDispatchQueuePriorityHigh;
    case QOS_CLASS_UTILITY:          return DKDispatchQueuePriorityLow;
    case QOS_CLASS_BACKGROUND:       return DKDispatchQueuePriorityBackground;
    case QOS_CLASS_DEFAULT:          break;
    case QOS_CLASS_UNSPECIFIED:      break;
    }
  #endif
    return DKDispatchQueuePriorityDefault;
}

DKDispatchQOSClass
dk_dispatch_queue_priority_to_qos_class(DKDispatchQueuePriority priority)
{
  #ifdef QOS_MIN_RELATIVE_PRIORITY
    switch ((dispatch_queue_priority_t)priority) {
    case DISPATCH_QUEUE_PRIORITY_HIGH:       return DKDispatchQOSClassUserInitiated;
    case DISPATCH_QUEUE_PRIORITY_LOW:        return DKDispatchQOSClassUtility;
    case DISPATCH_QUEUE_PRIORITY_BACKGROUND: return DKDispatchQOSClassBackground;
    case DISPATCH_QUEUE_PRIORITY_DEFAULT:    return DKDispatchQOSClassDefault;
    }
  #endif
    return DKDispatchQOSClassUnspecified;
}

dispatch_data_t
dk_dispatch_data_empty(void)
{
    return dispatch_data_empty;
}

dispatch_io_t
dk_dispatch_io_create_with_path(DKDispatchIOType type,
                                NSString *path, int oflag, mode_t mode,
                                dispatch_queue_t queue, void (^cleanup)(int error))
{
    return dispatch_io_create_with_path(type, path.UTF8String, oflag, mode, queue, cleanup);
}


dispatch_source_type_t
dk_dispatch_source_type_to_opaque(DKDispatchSourceType source_type)
{
    switch (source_type) {
    case DKDispatchSourceTypeUnspecified:    break;
    case DKDispatchSourceTypeDataAdd:        return DISPATCH_SOURCE_TYPE_DATA_ADD;
    case DKDispatchSourceTypeDataOr:         return DISPATCH_SOURCE_TYPE_DATA_OR;
    case DKDispatchSourceTypeMachRecv:       return DISPATCH_SOURCE_TYPE_MACH_RECV;
    case DKDispatchSourceTypeMachSend:       return DISPATCH_SOURCE_TYPE_MACH_SEND;
    case DKDispatchSourceTypeProc:           return DISPATCH_SOURCE_TYPE_PROC;
    case DKDispatchSourceTypeRead:           return DISPATCH_SOURCE_TYPE_READ;
    case DKDispatchSourceTypeSignal:         return DISPATCH_SOURCE_TYPE_SIGNAL;
    case DKDispatchSourceTypeTimer:          return DISPATCH_SOURCE_TYPE_TIMER;
    case DKDispatchSourceTypeVNode:          return DISPATCH_SOURCE_TYPE_VNODE;
    case DKDispatchSourceTypeWrite:          return DISPATCH_SOURCE_TYPE_WRITE;
    case DKDispatchSourceTypeMemoryPressure:
        return (dispatch_source_type_t)dk_dispatch_dlsym("_dispatch_source_type_memorypressure");
    }
    return NULL;
}

dispatch_source_t
dk_dispatch_source_create(DKDispatchSourceType type,
                          intptr_t handle,
                          unsigned long mask,
                          dispatch_queue_t queue)
{
    return dispatch_source_create(dk_dispatch_source_type_to_opaque(type), handle, mask, queue);
}
