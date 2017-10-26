//
//  BlockNumberParameter.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/25/17.
//

import Foundation
import BigInt
/*
/**
 Used in eth_getBlockTransactionCountByNumber call. Replaced with DefaultBlock
 */
public enum BlockNumberParameter {
    case number(BigInt)
    case defaultBlock(DefaultBlock)
}

extension BlockNumberParameter: Codable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .number(let number):
            try container.encode(number.hex)
        case .defaultBlock(let block):
            try container.encode(block.value)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        
        if stringValue.isValidHex(), let bigInt = BigInt(stringValue, radix: 16) {
            self = .number(bigInt)
        } else {
            let block = try DefaultBlock(string: stringValue)
            self = .defaultBlock(block)
        }
    }
} */
