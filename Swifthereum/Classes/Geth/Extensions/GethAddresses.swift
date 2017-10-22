//
//  GethAddresses.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

extension GethAddresses {
    
    /// Creates a [String] Array from the embedded strings in GethStrings
    open func array() throws -> [Address] {
        // Since Swift doesn't allow generics in protocols, we'll copy the same parser for every of Geth's array classes
        var array: [Address] = []
        for i in 0 ..< size() {
            let item = try get(i) 
            array.append(Address(address: item))
        }
        return array
    }
    
    public convenience init(items: [Address]) throws {
        self.init()
        for i in 0 ..< items.count - 1 {
            try set(i, address: items[i]._gethAddress)
        }
    }
}
