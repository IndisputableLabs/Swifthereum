//
//  NewTransaction.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/19/17.
//

import Foundation

/**
 
 Used to create a new transaction
 
 params: [{
 "from": "0xb60e8dd61c5d32be8058bb8eb970870f07233155",
 "to": "0xd46e8dd67c5d32be8058bb8eb970870f07244567",
 "gas": "0x76c0", // 30400,
 "gasPrice": "0x9184e72a000", // 10000000000000
 "value": "0x9184e72a", // 2441406250
 "data": "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"
 }]
 */
public struct NewTransaction {
    public let from: Address?
    public let to: Address
    public let gas: Wei?
    public let gasPrice: Wei?
    public let value: HashString?
    public let data: String?
    public let nonce: Int?
}

//extension NewTransaction: Codable {
//}

