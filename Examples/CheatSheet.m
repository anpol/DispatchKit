//
//  CheatSheet.m
//  DispatchKit
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKCheatSheet: NSObject
@end
#pragma GCC diagnostic ignored "-Wunused-variable"
@implementation DKCheatSheet

- (void)cheatQueues {

// Obtaining and Creating Queues

    dispatch_queue_t mainQueue =
        dispatch_get_main_queue();

    dispatch_queue_t globalQueue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_queue_t backgroundQueue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    dispatch_queue_t serialQueue =
        dispatch_queue_create("com.example.serial-queue",
                              DISPATCH_QUEUE_SERIAL);

// Queuing Tasks

    dispatch_sync(serialQueue, ^{
        // sync task
    });

    dispatch_queue_t concurrentQueue =
        dispatch_queue_create("com.example.concurrent-queue",
                              DISPATCH_QUEUE_CONCURRENT);

    dispatch_apply(42, concurrentQueue , ^(size_t i){
        NSLog(@"item #%ld", (long)i);
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // async task
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 42 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
        // ... code to be executed after a delay of 42 seconds
    });

// Waiting on Groups

    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, globalQueue,^{
        // task 1
    });
    
    dispatch_group_async(group, globalQueue,^{
        // task 2
    });
    
    dispatch_group_notify(group, globalQueue,^{
        // queued after tasks 1 and 2 were finished
    });

    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);

// Waiting on Semaphore

    dispatch_semaphore_t sema4 = dispatch_semaphore_create(4);

    dispatch_async(concurrentQueue, ^{
        dispatch_semaphore_wait(sema4, DISPATCH_TIME_FOREVER);
        // access some finite resource
        dispatch_semaphore_signal(sema4);
    });

}

@end
