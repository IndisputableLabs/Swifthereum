//
//  ArchivedTransaction.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/20/17.
//

import Foundation

public struct ArchivedTransaction {    
    public let hash: TransactionHash
    public let nonce: Int64
    public let blockHash: String
    public let transactionIndex: Int
    public let from: Address
    public let to: Address
    public let value: Wei
    public let gasPrice: Wei
    public let gas: Int64
    public let input: String
}
