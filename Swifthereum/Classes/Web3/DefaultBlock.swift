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

    case number(BlockNumber)            // An integer block number
    case genesis                        // The earliest/genesis block
    case latest                         // The last mined block
    case pending                        // Not yet mined
    case earliest                       // Not yet mined

    /**
     Returns the parameter value
     */
    public var value: String {
        switch self {
        case .number(let blockNumber):  return blockNumber.hexValue
        case .genesis:                  return "genesis"
        case .latest:                   return "latest"
        case .pending:                  return "pending"
        case .earliest:                 return "earliest"
        }
    }
    
    public init(string: String) throws {
        if string == "genesis" { self = .genesis }
        else if string == "latest" { self = .latest }
        else if string == "pending" { self = .pending }
        else if string == "earliest" { self = .earliest }
        else if let number = BlockNumber(string) { self = .number(number) }
        else if let number = Int64(hex: string) { self = .number(number) }
        else { throw SwifthereumError.encodingError }
    }
}

extension DefaultBlock: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case number, genesis, latest, pending, earliest
    }
    
    enum PostTypeCodingError: Error {
        case decoding(String)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        do {
            try self.init(string: stringValue)
        } catch {
            throw  DecodingError.dataCorruptedError(in: container, debugDescription: "\(stringValue) is not a valid block")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.value)        
    }
}
