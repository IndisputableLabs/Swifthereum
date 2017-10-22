//
//  32ByteHash.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/21/17.
//

import Foundation

/**
 32-bit Block hash
 */
public struct Bytes32Hash: HashProtocol {
    
    public let hash: HashString
    
    public static var hashLength: Int? = 64
    
    public init?(hex: HashString) {
        guard let hash = String(hex: hex, length: type(of: self).hashLength) else { return nil }
        self.hash = hash
    }
}

extension BlockHash {
    
}
