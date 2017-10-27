//
//  NewTransaction.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/19/17.
//

import Foundation
import BigInt

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
    public let value: BigInt?
    public let data: Hash?
    public let nonce: Int?

    public init(from: Address? = nil, to: Address, gas: Wei? = nil, gasPrice: Wei? = nil, value: BigInt? = nil, data: Hash? = nil, nonce: Int? = nil) {
        self.from = from
        self.to = to
        self.gas = gas
        self.gasPrice = gasPrice
        self.value = value
        self.data = data
        self.nonce = nonce
    }
    
}
extension NewTransaction: Encodable {
    
    private enum CodingKeys: String, CodingKey {
        case from, to, gas, gasPrice, value, data, nonce
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let from = from {
            try container.encode(String(describing:from), forKey: .from)
        }
        try container.encode(String(describing: to), forKey: .to)
        if let gas = gas {
            try container.encode("0x" + String(gas, radix: 16), forKey: .gas)
        }
        if let gasPrice = gasPrice {
            try container.encode("0x" + String(gasPrice, radix: 16), forKey: .gasPrice)
        }
        if let value = value {
            try container.encode("0x" + String(value, radix: 16), forKey: .value)
        }
        if let data = data {
            try container.encode("0x" + String(describing: data), forKey: .data)
        }
        if let nonce = nonce {
            try container.encode("0x" + nonce.hexValue, forKey: .nonce)
        }
    }
}

