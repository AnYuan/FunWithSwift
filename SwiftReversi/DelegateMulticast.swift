//
//  DelegateMulticast.swift
//  SwiftReversi
//
//  Created by Anyuan on 15/3/1.
//  Copyright (c) 2015年 razeware. All rights reserved.
//

import Foundation

// Provides a simple multicasting delegate implementation
class DelegateMulticast<T> {
    
    private var delegates = [T]()
    
    // add the given delegate as a receiver of notifications
    func addDelegate(delegate: T) {
        delegates.append(delegate)
    }
    
    // invokes the given function for each delegate
    func invokeDelegates(invocation: (T) -> ()) {
        for delegate in delegates {
            invocation(delegate)
        }
    }
}