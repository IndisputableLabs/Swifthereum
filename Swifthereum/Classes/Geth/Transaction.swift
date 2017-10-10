//
//  Transaction.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/22/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth
import BigInt

/**
 * Transaction represents a single Ethereum transaction.
 */
public struct Transaction {
    
    public let _gethTransaction: GethTransaction
    
    public var cost: BigInt { return BigInt(_gethTransaction.getCost()) }
    public var data: Data { return _gethTransaction.getData() }
    public var gas: Gas { return _gethTransaction.getGas() }
    public var gasPrice: BigInt { return BigInt(_gethTransaction.getGasPrice()) }
    public var hash: Hash { return Hash(hash: _gethTransaction.getHash()) }
    public var nonce: Int64 { return _gethTransaction.getNonce() }
    public var signatureHash: Hash { return Hash(hash: _gethTransaction.getSigHash()) }
    public var to: Address { return Address(address: _gethTransaction.getTo()) }
    public var value: BigInt { return BigInt(_gethTransaction.getValue().string())! }
    
    public init(transaction: GethTransaction) {
        _gethTransaction = transaction
    }
    
    /**
     NewTransaction creates a new transaction with the given properties.
     Original method: ```-(instancetype)init:(int64_t)nonce to:(GethAddress*)to amount:(GethBigInt*)amount gasLimit:(GethBigInt*)gasLimit gasPrice:(GethBigInt*)gasPrice data:(NSData*)data;```
     */
    init(nonce: Int64, to: Address, amount: BigInt, gasLimit: Gas, gasPrice: GasPrice, data: Data) {
        _gethTransaction = GethNewTransaction(nonce, to._gethAddress, GethBigInt(amount), GethBigInt(gasLimit), GethBigInt(gasPrice), data)
    }
    
    /**
     NewTransactionFromJSON parses a transaction from an JSON data dump.
     Original method: ```- (instancetype)initFromJSON:(NSString*)data;```
     */
    init(json: JSONDictionary) {
        _gethTransaction = GethTransaction(fromJSON: json.description)
    }
    
    /**
     NewTransactionFromRLP parses a transaction from an RLP data dump.
     Original method: ```- (instancetype)initFromRLP:(NSData*)data;```
     */
    init(rlp: Data) {
        _gethTransaction = GethTransaction(fromRLP: rlp)
    }
    
    /**     
     Original method: ```-(GethAddress*)getFrom:(GethBigInt*)chainID error:(NSError**)error;```
     */
    func from(chainID: ChainID) throws -> Address {
        let gethAddress = try _gethTransaction.getFrom(GethBigInt(chainID.rawValue))
        return Address(address: gethAddress)
    }
    
    /** Orginal method: ```-(GethTransaction*)withSignature:(NSData*)sig chainID:(GethBigInt*)chainID error:(NSError**)error;```
     */
    func transaction(withSignature signature: Data, chainID: ChainID) throws -> Transaction {
        let gethTransaction = try _gethTransaction.withSignature(signature, chainID: GethBigInt(chainID.rawValue))
        return Transaction(transaction: gethTransaction)
    }
}


//extension Transaction: Codable {
//    public func encode(to encoder: Encoder) throws {
////        try encoder.
//    }
//}

extension Transaction: CustomStringConvertible {
    
    public var description: String {
        return """
            \(hash)
            Signature: \(signatureHash)
            To: \(to)
            Value: \(value)
            Cost: \(cost)
            Nonce: \(nonce)
        """
    }
}

extension Transaction {
    
    public static func transactions(_ gethTransactions: GethTransactions) throws -> [Transaction] {
        var transactions = [Transaction]()
        for i in 0 ..< gethTransactions.size() {
            let transaction = try Transaction(transaction: gethTransactions.get(i))
            transactions.append(transaction)
        }
        return transactions
    }
}

/*
extension Transaction: Hashable {
    public var hashValue: Int {
        <#code#>
    }
    
    public static func ==(lhs: Transaction, rhs: Transaction) -> Bool {
        <#code#>
    }
} */




