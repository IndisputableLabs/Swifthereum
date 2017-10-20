//
//  DefaultBlock.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/19/17.
//

import Foundation

/**
 The following methods have an extra default block parameter:
 - eth_getBalance
 - eth_getCode
 - eth_getTransactionCount
 - eth_getStorageAt
 - eth_call
 */
public enum DefaultBlock {

    case hex(BlockNumber)   // an integer block number
    case genesis            // the earliest/genesis block
    case latest             // the latest mined block
    case pending

    /**
     Returns the parameter value
     */
    public var value: String {
        switch self {
        case .hex(let blockNumber): return blockNumber.hexValue
        case .genesis:              return "earliest"
        case .latest:               return "latest"
        case .pending:              return "pending"
        }
    }
}
