//
//  Header.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth
import BigInt

/**
 * Header represents a block header in the Ethereum blockchain.
 */
open class Header {
    
    open let _gethHeader: GethHeader
    
    open var bloom: Bloom { return Bloom(gethBloom: _gethHeader.getBloom()) }
    
    open var coinBase: Address { return Address(address: _gethHeader.getCoinbase()) }
    
    open var difficulty: BigInt { return BigInt(_gethHeader.getDifficulty()) }
    
    open var extra: Data { return _gethHeader.getExtra() }
    
    open var gasLimit: Int64 { return _gethHeader.getGasLimit() }
    
    open var gasUser: Int64 { return _gethHeader.getGasUsed() }
    
    open var hash: Hash { return Hash(hash: _gethHeader.getHash()) }
    
    open var mixDigest: Hash { return Hash(hash: _gethHeader.getMixDigest()) }
    
    open var nonce: Nonce { return Nonce(gethNonce: _gethHeader.getNonce()) }
    
    open var number: Int64 { return _gethHeader.getNumber() }
    
    open var parentHash: Hash { return Hash(hash: _gethHeader.getParentHash()) }
    
    open var receiptHash: Hash { return Hash(hash: _gethHeader.getReceiptHash()) }
    
    open var root: Hash { return Hash(hash: _gethHeader.getRoot()) }
    
    open var time: TimeInterval { return TimeInterval(_gethHeader.getTime()) }
    
    open var txHash: Hash { return Hash(hash: _gethHeader.getTxHash()) }
    
    open var uncleHash: Hash { return Hash(hash: _gethHeader.getUncleHash()) }
    
    /**
     * String implements the fmt.Stringer interface to print some semi-meaningful
     data dump of the header for debugging purposes.
     */
    var string: String { return _gethHeader.string() }
    
    public init(gethHeader: GethHeader) {
        _gethHeader = gethHeader
    }
    
    /**
     * NewHeaderFromRLP parses a header from an RLP data dump.
     */
    public init(rlp: Data) {
        _gethHeader = GethHeader(fromRLP: rlp)
    }
    
    /**
     * EncodeRLP encodes a header into an RLP data dump.
     */
    open func encodeRLP() throws -> Data {
        return try _gethHeader.encodeRLP()
    }
    
}

//extension Header: Codable {
//    /**
//     * NewHeaderFromJSON parses a header from an JSON data dump.
//     */
//    /**
//     * EncodeJSON encodes a header into an JSON data dump.
//     */
//    open convenience init(from decoder: Decoder) throws {
//        
//    }
//}

