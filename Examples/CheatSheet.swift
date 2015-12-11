//
//  CheatSheet.swift
//  DispatchKit <https://github.com/anpol/DispatchKit>
//
//  Copyright (c) 2014 Andrei Polushin. All rights reserved.
//








func cheatQueues() {

// Obtaining and Creating Queues

    let mainQueue = Dispatch.mainQueue


    let globalQueue = Dispatch.globalQueue


    let backgroundQueue = Dispatch.getGlobalQueue(priority: .Background)


    let serialQueue = DispatchQueue("com.example.serial-queue")


// Using Enumerations
// Queuing Tasks

    serialQueue.sync {
        // sync task
    }

    let concurrentQueue = DispatchQueue("com.example.concurrent-queue",
                                        attr: .Concurrent)


    concurrentQueue.apply(42) { i in
        print("item #\(i)")
    }
    
    Dispatch.globalQueue.async {
        // async task
    }

    Dispatch.mainQueue.after(.Now + .Seconds(42)) {
        // ... code to be executed after a delay of 42 seconds
    }

// Using Time
// Waiting on Groups

    let group = DispatchGroup()

    globalQueue.async(group) {
        // task 1
    }

    globalQueue.async(group) {
        // task 2
    }

    group.notify(globalQueue) {
        // queued after tasks 1 and 2 were finished
    }

    group.wait()

// Waiting on Semaphore

    let sema4 = DispatchSemaphore(4);

    concurrentQueue.async {
        sema4.wait()
        // access some finite resource
        sema4.signal()
    }

}

// @end
