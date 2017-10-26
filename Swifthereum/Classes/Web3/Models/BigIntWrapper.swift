//
//  BigIntWrapper.swift
//  BigInt
//
//  Created by Ronald Mannak on 10/22/17.
//

import Foundation
import BigInt

/**
 Wrapper for BigInt to encode / decode Ethereum hexStrings
 */
public struct BigIntWrapper {
    public let bigInt: BigInt
    
    public init?(_ stringValue: String) {
        let radix: Int = stringValue.isValidHex() ? 16 : 10

        guard let bigInt = BigInt(stringValue.remove0xPrefix(), radix: radix) else { return nil }
        self.bigInt = bigInt
    }
}

extension BigIntWrapper: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        
        let radix: Int = stringValue.isValidHex() ? 16 : 10
        
        guard let bigInt = BigInt(stringValue.remove0xPrefix(), radix: radix) else {
            throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Invalid hexadecimal string"))
        }
        self.bigInt = bigInt
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(bigInt.hex)
    }
}
