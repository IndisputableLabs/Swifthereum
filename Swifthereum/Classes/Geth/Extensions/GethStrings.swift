//
//  GethStrings.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/23/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

extension GethStrings {
    
    /// Creates a [String] Array from the embedded strings in GethStrings
    open var array: [String] {
        // Since Swift doesn't allow generics in protocols, we'll copy the same parser for every of Geth's array classes
        var array: [String] = []
        for i in 0 ..< size() {
            guard let item = try? get(i) else { continue }
            array.append(item)
        }
        return array
    }
    
    public convenience init(items: [String]) throws {
        self.init()
        for i in 0 ..< items.count - 1 {
            try set(i, str: items[i])
        }
    }
}

