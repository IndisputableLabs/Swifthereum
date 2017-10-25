//
//  EnumCollection.swift
//  UnitTests
//
//  Created by Ronald Mannak on 10/24/17.
//  Copyright © 2017 Indisputable Labs. All rights reserved.
//

import Foundation

// Original source: https://theswiftdev.com/2017/10/12/swift-enum-all-values/
// Alternative: https://gist.github.com/designatednerd/390016f38c7f9559484c3bdcace066e1

public protocol EnumCollection: Hashable {
    static func cases() -> AnySequence<Self>
    static var allValues: [Self] { get }
}

public extension EnumCollection {
    
    public static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    public static var allValues: [Self] {
        return Array(self.cases())
    }
}
