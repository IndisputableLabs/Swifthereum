//
//  EthereumNotification.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/21/17.
//

import Foundation

/**
 fromBlock: QUANTITY|TAG - (optional, default: "latest") Integer block number, or "latest" for the last mined block or "pending", "earliest" for not yet mined transactions.
 toBlock: QUANTITY|TAG - (optional, default: "latest") Integer block number, or "latest" for the last mined block or "pending", "earliest" for not yet mined transactions.
 address: DATA|Array, 20 Bytes - (optional) Contract address or a list of addresses from which logs should originate.
 topics: Array of DATA, - (optional) Array of 32 Bytes DATA topics. Topics are order-dependent. Each topic can also be an array of DATA with "or" options.
 */
public struct EthereumNotification: Codable {
    let fromBlock: DefaultBlock
    let toBlock: DefaultBlock
    let address: Address?
    let topics: [BlockHash]?
}
