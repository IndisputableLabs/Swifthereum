//
//  TransactionHash.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/19/17.
//

import Foundation

public typealias TransactionHash = String

/**
 32-bit transaction hash
 */
extension TransactionHash {
    
    public init?(transaction: String) {
        let hashLength = 32
        self.init(hex: transaction, length: hashLength)
    }
}
