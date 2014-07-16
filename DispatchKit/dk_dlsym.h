//
//  dk_dlsym.h
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

#import "dk_enums.h"

@protocol DispatchCookie;


DISPATCH_NONNULL_ALL DISPATCH_PURE DISPATCH_WARN_RESULT
id<DispatchCookie>
dk_dispatch_get_context(dispatch_object_t object);


DISPATCH_NONNULL1 DISPATCH_NONNULL2 DISPATCH_NOTHROW
void
dk_dispatch_set_context(dispatch_object_t object, id<DispatchCookie> cookie);


DISPATCH_NONNULL_ALL DISPATCH_PURE DISPATCH_WARN_RESULT
id<DispatchCookie>
dk_dispatch_queue_get_specific(dispatch_queue_t queue, const void *key);


DISPATCH_NONNULL1 DISPATCH_NONNULL2 DISPATCH_NOTHROW
void
dk_dispatch_queue_set_specific(dispatch_queue_t queue, const void *key, id<DispatchCookie> cookie);


DISPATCH_NONNULL_ALL DISPATCH_PURE DISPATCH_WARN_RESULT
id<DispatchCookie>
dk_dispatch_get_specific(const void *key);


DISPATCH_CONST DISPATCH_NOTHROW
dispatch_queue_t
dk_dispatch_get_main_queue(void);


DISPATCH_WARN_RESULT DISPATCH_NOTHROW
BOOL dk_dispatch_has_qos_class();


DISPATCH_MALLOC DISPATCH_RETURNS_RETAINED DISPATCH_WARN_RESULT DISPATCH_NOTHROW
dispatch_queue_t
dk_dispatch_queue_create_with_qos_class(NSString *label, dispatch_queue_attr_t attr,
                                        DKDispatchQOSClass qos_class,
                                        NSInteger relative_priority);


DISPATCH_WARN_RESULT DISPATCH_CONST DISPATCH_NOTHROW
DKDispatchQueuePriority
dk_dispatch_qos_class_to_priority(DKDispatchQOSClass qos_class);


DISPATCH_WARN_RESULT DISPATCH_CONST DISPATCH_NOTHROW
DKDispatchQOSClass
dk_dispatch_queue_priority_to_qos_class(DKDispatchQueuePriority priority);


DISPATCH_CONST DISPATCH_NOTHROW
dispatch_data_t
dk_dispatch_data_empty(void);


DISPATCH_NONNULL2 DISPATCH_MALLOC DISPATCH_RETURNS_RETAINED DISPATCH_WARN_RESULT DISPATCH_NOTHROW
dispatch_io_t
dk_dispatch_io_create_with_path(DKDispatchIOType type,
                                NSString *path, int oflag, mode_t mode,
                                dispatch_queue_t queue, void (^cleanup)(int error));


dispatch_source_type_t
dk_dispatch_source_type_to_opaque(DKDispatchSourceType source_type);


DISPATCH_MALLOC DISPATCH_RETURNS_RETAINED DISPATCH_WARN_RESULT DISPATCH_NOTHROW
dispatch_source_t
dk_dispatch_source_create(DKDispatchSourceType type,
                          intptr_t handle,
                          unsigned long mask,
                          dispatch_queue_t queue);
