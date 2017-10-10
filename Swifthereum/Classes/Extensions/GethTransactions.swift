//
//  GethTransactions.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

extension GethTransactions {
    
    /// Creates a [String] Array from the embedded strings in GethStrings
    open func array() throws -> [Transaction] {
        // Since Swift doesn't allow generics in protocols, we'll copy the same parser for every of Geth's array classes
        var array: [Transaction] = []
        for i in 0 ..< size() {
            guard let item = try? get(i) else { continue }
            array.append(Transaction(transaction: item))
        }
        return array
    }
    
    public convenience init(items: [Transaction]) throws {
        self.init()
        assertionFailure() // TODO:
//        for i in 0 ..< items.count - 1 {
//            try set(i, address: items[i]._gethTransaction)
//        }
    }
}
