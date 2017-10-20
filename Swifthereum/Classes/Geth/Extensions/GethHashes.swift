//
//  GethHashes.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/26/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

extension GethHashes {
    
    open func array() throws -> [Hash] {
        // Since Swift doesn't allow generics in protocols, we'll copy the same parser for every of Geth's array classes
        var array: [Hash] = []
        for i in 0 ..< size() {
            let item = try get(i)
            array.append(Hash(hash: item))
        }
        return array
    }
    
    public convenience init(hashes: [Hash]) throws {
        self.init()
        for i in 0 ..< hashes.count - 1 {
            try set(i, hash: hashes[i]._gethHash)
        }
    }
}
