//
//  Address.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/18/17.
//

import Foundation
import BigInt

public struct Address: HashProtocol {

    public let hash: HashString
    
    public static var hashLength: Int? = 40 // 20 bytes
    
    public init?(hex: HashString) {
        guard let hash = String(hex: hex, length: type(of: self).hashLength) else { return nil }
        self.hash = hash
    }
}

// Codable
extension Address: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        guard let hash = String(hex: stringValue, length: type(of: self).hashLength) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "\(stringValue) is not a valid address")
        }
        self.hash = hash
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = try encoder.singleValueContainer()
        try container.encode(String(describing: hash))
    }
}

extension Address {
    /**
     Returns the balance of the account of given address.
     */
    // TODO: Change back to BigInt. Issue is that result is hex ("0x317604574664c00")
//    public func balance(swifthereum: Swifthereum, defaultBlock: DefaultBlock = .latest, completion: @escaping (Result<String>) -> ()) {
//        let method = Method.balance(self, defaultBlock)
//        swifthereum.fetch(method: method) { (result: Result<String>) in
//            completion(result)
//        }
//    }
    public func balance(swifthereum: Swifthereum, defaultBlock: DefaultBlock = .latest, completion: @escaping (Result<Wei>) -> ()) throws {
        try swifthereum.balance(for: self, completion: completion)
    }
}
