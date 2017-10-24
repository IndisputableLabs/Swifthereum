//
//  Block.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/19/17.
//

import Foundation
import BigInt

/**
 number: QUANTITY - the block number. null when its pending block.
 hash: DATA, 32 Bytes - hash of the block. null when its pending block.
 parentHash: DATA, 32 Bytes - hash of the parent block.
 nonce: DATA, 8 Bytes - hash of the generated proof-of-work. null when its pending block.
 sha3Uncles: DATA, 32 Bytes - SHA3 of the uncles data in the block.
 logsBloom: DATA, 256 Bytes - the bloom filter for the logs of the block. null when its pending block.
 transactionsRoot: DATA, 32 Bytes - the root of the transaction trie of the block.
 stateRoot: DATA, 32 Bytes - the root of the final state trie of the block.
 receiptsRoot: DATA, 32 Bytes - the root of the receipts trie of the block.
 miner: DATA, 20 Bytes - the address of the beneficiary to whom the mining rewards were given.
 difficulty: QUANTITY - integer of the difficulty for this block.
 totalDifficulty: QUANTITY - integer of the total difficulty of the chain until this block.
 extraData: DATA - the "extra data" field of this block.
 size: QUANTITY - integer the size of this block in bytes.
 gasLimit: QUANTITY - the maximum gas allowed in this block.
 gasUsed: QUANTITY - the total used gas by all transactions in this block.
 timestamp: QUANTITY - the unix timestamp for when the block was collated.
 transactions: Array - Array of transaction objects, or 32 Bytes transaction hashes depending on the last given parameter.
 uncles: Array - Array of uncle hashes.
 */
public struct Block {
    public let number: Int64?
    public let blockHash: BlockHash?
    public let parentHash: BlockHash?
    public let nonce: Hash?
    public let sha3Uncles: [BlockHash]?
    public let logsBloom: Hash
    public let transactionsRoot: Hash
    public let stateRoot: Hash
//    public let receiptRoot: Hash? Not in JSON?
    public let miner: Address
    public let difficulty: BigInt
    public let totalDifficulty: BigInt
    public let extraData: Hash?
    public let size: Int64
    public let gasLimit: Wei
    public let gasUsed: Wei
    public let timeStamp: TimeInterval
    public let transactions: [TransactionHash]?
//    public let transactionHashes: [TransactionHash]? Not in JSON
    public let uncles: [BlockHash]?

    // Initializers of public structs are internal
    // https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AccessControl.html#//apple_ref/doc/uid/TP40014097-CH41-ID3
    public init(number: Int64?,
                blockHash: BlockHash?,
                parentHash: BlockHash?,
                nonce: Hash?,
                sha3Uncles: [BlockHash]?,
                logsBloom: Hash,
                transactionsRoot: Hash,
                stateRoot: Hash,
                miner: Address,
                difficulty: BigInt,
                totalDifficulty: BigInt,
                extraData: Hash?,
                size: Int64,
                gasLimit: Wei,
                gasUsed: Wei,
                timeStamp: TimeInterval,
                transactions: [TransactionHash]?,
                uncles: [BlockHash]?) {
        self.number = number
        self.blockHash = blockHash
        self.parentHash = parentHash
        self.nonce = nonce
        self.sha3Uncles = sha3Uncles
        self.logsBloom = logsBloom
        self.transactionsRoot = transactionsRoot
        self.stateRoot = stateRoot
        self.miner = miner
        self.difficulty = difficulty
        self.totalDifficulty = totalDifficulty
        self.extraData = extraData
        self.size = size
        self.gasLimit = gasLimit
        self.gasUsed = gasUsed
        self.timeStamp = timeStamp
        self.transactions = transactions
        self.uncles = uncles
    }
}

//extension Block: Codable {
//
//}

