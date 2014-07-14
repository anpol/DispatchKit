=======================================================
 DispatchKit – iOS and OS X Framework written in Swift
=======================================================

.. vim:spell:spelllang=en
.. contents::


Goal
====

The project aims to provide an idiomatic Swift language wrapper for the
`Grand Central Dispatch`_ Framework, also known as GCD, or libdispatch_ library.

    Current implementation is based on publicly available `Swift prerelease`_ and
    `GCD prerelease`_ documentation. The implementation is subject to change.

If you are familiar with the C-based GCD API, you can continually apply your knowledge
when writing Swift code, because the DispatchKit API closely matches the original API.

Otherwise, if you have little or no experience with GCD, then probably the DispatchKit is
a good place to start playing with, as it allows you to learn GCD in a much more cleaner way.
Swift is a more type safe and less error-prone language than Objective-C, and the DispatchKit
uses strict types and short method names to wrap GCD types and functions.

In addition, the DispatchKit is assumed to have zero overhead compared to GCD code written
in C or Objective-C using the original API. That's because DispatchKit wrappers are just
tiny structs, which do not require expensive memory allocation themselves.


Usage
=====

Usage examples are provided in Swift using DispatchKit, compared to Objective-C code
using the original GCD API.


Obtaining and Creating Queues
-----------------------------

+---------------------------------------------------------------------------+---------------------------------------------------------------------------------------+
|                                   Swift                                   |                                      Objective-C                                      |
+===========================================================================+=======================================================================================+
|.. code:: swift                                                            |.. code:: objc                                                                         |
|                                                                           |                                                                                       |
|   let mainQueue = Dispatch.mainQueue                                      |   dispatch_queue_t mainQueue =                                                        |
|                                                                           |       dispatch_get_main_queue();                                                      |
|                                                                           |                                                                                       |
|   let globalQueue = Dispatch.globalQueue                                  |   dispatch_queue_t globalQueue =                                                      |
|                                                                           |       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);                  |
|                                                                           |                                                                                       |
|   let backgroundQueue = Dispatch.getGlobalQueue(priority: .Background)    |   dispatch_queue_t backgroundQueue =                                                  |
|                                                                           |       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);               |
|                                                                           |                                                                                       |
|   let serialQueue = DispatchQueue("com.example.serial-queue")             |   dispatch_queue_t serialQueue =                                                      |
|                                                                           |       dispatch_queue_create("com.example.serial-queue",                               |
|                                                                           |                             DISPATCH_QUEUE_SERIAL);                                   |
+---------------------------------------------------------------------------+---------------------------------------------------------------------------------------+


Using Enumerations
------------------

As shown an the previous example, the GCD constants are mapped into the Swift enumerations.

For instance, the ``DISPATCH_QUEUE_PRIORITY_*`` constants are mapped as follows:

.. code:: swift

    enum DispatchQueuePriority : dispatch_queue_priority_t {
        case High = DISPATCH_QUEUE_PRIORITY_HIGH
        case Default = DISPATCH_QUEUE_PRIORITY_DEFAULT
        case Low = DISPATCH_QUEUE_PRIORITY_LOW
        case Background = DISPATCH_QUEUE_PRIORITY_BACKGROUND
    }

Actual mapping is performed by the Swift compiler behind the scenes. Refer to
`dk_enums.h <DispatchKit/dk_enums.h>`_ for the corresponding Objective-C code.


Queuing Tasks
-------------

+---------------------------------------------------------------------------+---------------------------------------------------------------------------------------+
|                                   Swift                                   |                                      Objective-C                                      |
+===========================================================================+=======================================================================================+
|.. code:: swift                                                            |.. code:: objc                                                                         |
|                                                                           |                                                                                       |
|   serialQueue.sync {                                                      |   dispatch_sync(serialQueue, ^{                                                       |
|       // sync task                                                        |       // sync task                                                                    |
|   }                                                                       |   });                                                                                 |
|                                                                           |                                                                                       |
|   let concurrentQueue = DispatchQueue("com.example.concurrent-queue",     |   dispatch_queue_t concurrentQueue =                                                  |
|                                       attr: .Concurrent)                  |       dispatch_queue_create("com.example.concurrent-queue",                           |
|                                                                           |                             DISPATCH_QUEUE_CONCURRENT);                               |
|                                                                           |                                                                                       |
|   concurrentQueue.apply(42) { i in                                        |   dispatch_apply(42, concurrentQueue , ^(size_t i){                                   |
|       println("item #\(i)")                                               |       NSLog(@"item #%ld", (long)i);                                                   |
|   }                                                                       |   });                                                                                 |
|                                                                           |                                                                                       |
|   Dispatch.globalQueue.async {                                            |   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{    |
|       // async task                                                       |       // async task                                                                   |
|   }                                                                       |   });                                                                                 |
|                                                                           |                                                                                       |
|   Dispatch.mainQueue.after(.Now + .Seconds(42)) {                         |   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 42 * NSEC_PER_SEC),                 |
|       // ... code to be executed after a delay of 42 seconds              |                  dispatch_get_main_queue(), ^{                                        |
|   }                                                                       |       // ... code to be executed after a delay of 42 seconds                          |
|                                                                           |   });                                                                                 |
+---------------------------------------------------------------------------+---------------------------------------------------------------------------------------+


Using Time
----------

The previous example uses time expressions. Other forms of time expressions are also possible:

.. code:: swift

    .Now + .Seconds(3) + .Milliseconds(145) + .Microseconds(926) + .Nanoseconds(535)
    .WallClock(timespec) + .Days(5) + .Hours(40)

Refer to `DispatchTime.swift <DispatchKit/DispatchTime.swift>`_ for further details.

An additional ``.Forever`` constant is used by default with ``wait()`` method defined
for groups and semaphores.


Waiting on Groups
-----------------

+---------------------------------------------------------------------------+---------------------------------------------------------------------------------------+
|                                   Swift                                   |                                      Objective-C                                      |
+===========================================================================+=======================================================================================+
|.. code:: swift                                                            |.. code:: objc                                                                         |
|                                                                           |                                                                                       |
|   let group = DispatchGroup()                                             |   dispatch_group_t group = dispatch_group_create();                                   |
|                                                                           |                                                                                       |
|   globalQueue.async(group) {                                              |   dispatch_group_async(group, globalQueue,^{                                          |
|       // task 1                                                           |       // task 1                                                                       |
|   }                                                                       |   });                                                                                 |
|                                                                           |                                                                                       |
|   globalQueue.async(group) {                                              |   dispatch_group_async(group, globalQueue,^{                                          |
|       // task 2                                                           |       // task 2                                                                       |
|   }                                                                       |   });                                                                                 |
|                                                                           |                                                                                       |
|   group.notify(globalQueue) {                                             |   dispatch_group_notify(group, globalQueue,^{                                         |
|       // queued after tasks 1 and 2 were finished                         |       // queued after tasks 1 and 2 were finished                                     |
|   }                                                                       |   });                                                                                 |
|                                                                           |                                                                                       |
|   group.wait()                                                            |   dispatch_group_wait(group, DISPATCH_TIME_FOREVER);                                  |
|                                                                           |                                                                                       |
+---------------------------------------------------------------------------+---------------------------------------------------------------------------------------+


Waiting on Semaphore
--------------------

+---------------------------------------------------------------------------+---------------------------------------------------------------------------------------+
|                                   Swift                                   |                                      Objective-C                                      |
+===========================================================================+=======================================================================================+
|.. code:: swift                                                            |.. code:: objc                                                                         |
|                                                                           |                                                                                       |
|   let sema4 = DispatchSemaphore(4);                                       |   dispatch_semaphore_t sema4 = dispatch_semaphore_create(4);                          |
|                                                                           |                                                                                       |
|   concurrentQueue.async {                                                 |   dispatch_async(concurrentQueue, ^{                                                  |
|       sema4.wait()                                                        |       dispatch_semaphore_wait(sema4, DISPATCH_TIME_FOREVER);                          |
|       // access some finite resource                                      |       // access some finite resource                                                  |
|       sema4.signal()                                                      |       dispatch_semaphore_signal(sema4);                                               |
|   }                                                                       |   });                                                                                 |
|                                                                           |                                                                                       |
|                                                                           |                                                                                       |
|                                                                           |                                                                                       |
+---------------------------------------------------------------------------+---------------------------------------------------------------------------------------+


Dispatch I/O
------------

For details, refer to
`DispatchIO.swift <DispatchKit/DispatchIO.swift>`_ and
`DispatchData.swift <DispatchKit/DispatchData.swift>`_.


Dispatch Sources
----------------

For details, refer to
`DispatchSource.swift <DispatchKit/DispatchSource.swift>`_ and various flags declared in
`DispatchSourceType.swift <DispatchKit/DispatchSourceType.swift>`_ and
`dk_enums.h <DispatchKit/dk_enums.h>`_.


Compatibility
=============

The DispatchKit is designed to be source-compatible with iOS 7 SDK, binary-compatible with iOS 7 platform.

    More information could be provided after a subsequent release of iOS 8.


License 
=======

The DispatchKit is available under the `MIT License <LICENSE.rst>`_.


.. References:
.. _Grand Central Dispatch: https://developer.apple.com/library/ios/documentation/Performance/Reference/GCD_libdispatch_Ref/
.. _libdispatch: http://libdispatch.macosforge.org
.. _Swift prerelease: https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/
.. _GCD prerelease: https://developer.apple.com/library/prerelease/ios/documentation/Performance/Reference/GCD_libdispatch_Ref/index.html

