//
//  Hash.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

// TODO: move this to typeAlias and extension of String(?)
/**
 Hash represents the 32 byte Keccak256 hash of arbitrary data.
 
 64 char / 32 byte can be a private key: https://ethereum.stackexchange.com/questions/3542/how-are-ethereum-addresses-generated
 what about 128 char / 64 byte open key?
 */
public struct Hash {
    
    public let _gethHash: GethHash
    
    /**
     GetBytes retrieves the byte representation of the hash.
     */
    var bytes: Data { return _gethHash.getBytes() }
    /**
     * GetHex retrieves the hex string representation of the hash.
     */
    var hex: String { return _gethHash.getHex() }
    
    public init(hash: GethHash) {
        _gethHash = hash
    }
    
    /**
     NewHashFromBytes converts a slice of bytes to a hash value.
     */
    public init?(bytes: Data) {
        guard let hash = GethHash(fromBytes: bytes) else { return nil }
        _gethHash = hash
    }
    
    /**
     NewHashFromHex converts a hex string to a hash value.
     */
    public init?(hex: String) {
        guard let hash = GethHash(fromHex: hex) else { return nil }
        _gethHash = hash
    }
}

//extension Hash: Codable {
//    open init(from decoder: Decoder) throws {
//        
//    }
//}

