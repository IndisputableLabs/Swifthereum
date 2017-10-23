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
public struct BigIntWrapper: Decodable {
    public let bigInt: BigInt
    
    public init(from decoder: Decoder) throws {
        
        // If big int is unkeyed
        let container = try decoder.singleValueContainer()  // unkeyedContainer() // could be in result or a value
        var bigIntString = try container.decode(String.self)
        
        if bigIntString.hasPrefix("0x") {
            bigIntString = String(bigIntString.dropFirst(2))
            guard let bigInt = BigInt(bigIntString, radix: 16) else {
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath,
                                                        debugDescription: "Invalid hexadecimal string"))
            }
            self.bigInt = bigInt
        } else {
            guard let bigInt = BigInt(bigIntString) else {
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath,
                                                        debugDescription: "Invalid decimal string"))
            }
            self.bigInt = bigInt
        }
    }
}
