//
//  Block.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/21/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth
import BigInt

//public enum GenesisBlock {
//    case MainNet, TestNet
//}

/* Example genesis block from https://souptacular.gitbooks.io/ethereum-tutorials-and-tips-by-hudson/content/private-chain.html
 {
 "nonce": "0x0000000000000042",
 "timestamp": "0x0",
 "parentHash": "0x0000000000000000000000000000000000000000000000000000000000000000",
 "extraData": "0x0",
 "gasLimit": "0x8000000",
 "difficulty": "0x400",
 "mixhash": "0x0000000000000000000000000000000000000000000000000000000000000000",
 "coinbase": "0x3333333333333333333333333333333333333333",
 "alloc": {
 }
 }
 */
public struct Block {
    
    let _gethBlock: GethBlock
    
    public let bloom: Bloom
    public let coinBase: Address
    public var difficulty: BigInt
    public var extra: Data
    public var gasLimit: Int64
    public var gasUsed: Int64
    
    public var mixDigest: Hash
    public var nonce: Int64
    public var number: BlockNumber
    public var parentHash: Hash
    public var receiptHash: Hash
    public var time: TimeInterval
    public var transactions: [Transaction]
    public var txHash: Hash
    public var uncleHash: Hash
    public var uncles: [Header]
    public var string: String?
    
    public init(block: GethBlock) throws {
        _gethBlock      = block
        bloom           = Bloom(gethBloom: block.getBloom())
        coinBase        = Address(address: block.getCoinbase())
        difficulty      = BigInt(block.getDifficulty())
        extra           = block.getExtra()
        gasLimit        = block.getGasLimit()
        gasUsed         = block.getGasUsed()
        mixDigest       = Hash(hash: block.getMixDigest())
        nonce           = block.getNonce()
        number          = block.getNumber()
        parentHash      = Hash(hash: block.getParentHash())
        receiptHash     = Hash(hash: block.getReceiptHash())
        number          = block.getNumber()
        time            = TimeInterval(block.getTime())
        transactions    = try Transaction.transactions(block.getTransactions())
        txHash          = Hash(hash: block.getTxHash())
        uncleHash       = Hash(hash: block.getUncleHash())
        uncles          = try block.getUncles().array()
        string          = block.string()
    }
    
    /**
     * NewBlockFromJSON parses a block from an JSON data dump.
     */
    public init(json: JSONDictionary) throws {
        var error: NSError? = nil
        let gethBlock = GethNewBlockFromJSON(json.description, &error)
        guard error == nil else { throw(error!) }
        guard let block = gethBlock else { throw(SwifthereumError.invalidJSON) }
        try self.init(block: block)
    }
    
    /**
     * NewBlockFromRLP parses a block from an RLP data dump.
     */
    public init(rlp: Data) throws {
        var error: NSError? = nil
        let gethBlock = GethNewBlockFromRLP(rlp, &error)
        guard error == nil else { throw(error!) }
        guard let block = gethBlock else { throw(SwifthereumError.invalidRLP) }
        try self.init(block: block)
    }
    
    /// ```-(GethTransaction*)getTransaction:(GethHash*)hash;```
    func transaction(hash: Hash) -> Transaction {
        return Transaction(transaction: _gethBlock.getTransaction(hash._gethHash))
    }
    
//    public convenience init(genesis: GenesisBlock) {
//        let genesisString: String
//        switch genesis {
//        case .MainNet:
//            genesisString = GethMainnetGenesis()
//        case .TestNet:
//            genesisString = GethTestnetGenesis()
//        }
//        self.init(string: genesisString)
//    }
}

extension Block: Hashable {
    public var hashValue: Int {
        return 0
    }
    
    public static func ==(lhs: Block, rhs: Block) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    // hashNoNonce?
}

//extension Block: Codable {
//    init(from: Decoder) {
//
//    }
//}



