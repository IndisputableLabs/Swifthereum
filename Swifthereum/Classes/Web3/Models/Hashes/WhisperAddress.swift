//
//  WhisperAddress.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/25/17.
//

import Foundation
import BigInt

public struct WhisperAddress: HashProtocol {
    
    public let hash: HashString
    
    // According to the documentation, a whisper address is 30 bytes (hex length 60 characters)
    // The example uses 65 bytes (130 charater) for whisper addresses.
    // Assuming that the example is correct for now
    // https://github.com/ethereum/wiki/wiki/JSON-RPC#shh_post
    public static var hashLength: Int? = 130 // 65 bytes //60 // 30 bytes
    
    public init?(hex: HashString) {
        guard let hash = String(hex: hex, length: type(of: self).hashLength) else { return nil }
        self.hash = hash
    }
}

// Codable
extension WhisperAddress {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        guard let hash = String(hex: stringValue, length: type(of: self).hashLength) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "\(stringValue) is not a valid address")
        }
        self.hash = hash
    }
}
