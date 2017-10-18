//
//  EthereumClient.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/23/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth
import BigInt

protocol EthereumClientProtocol {
//    func ethereumClient(_: EthereumClient, didDoSomething like: String)
}

/*
 Solidity includes 7 basic types, listed below:
 
 hash: 256-bit, 32-byte data chunk, indexable into bytes and operable with bitwise operations.
 uint: 256-bit unsigned integer, operable with bitwise and unsigned arithmetic operations.
 int: 256-bit signed integer, operable with bitwise and signed arithmetic operations.
 string32: zero-terminated ASCII string of maximum length 32-bytes (256-bit).
 address: account identifier, similar to a 160-bit hash type.
 bool: two-state value.
 */

/**
 EthereumClient provides access to the Ethereum APIs.
 Do or don't create one? Let Node create one for you?
 */
open class EthereumClient {
    
    open let _gethEthereumClient: GethEthereumClient
    
    public init(client: GethEthereumClient) {
        _gethEthereumClient = client
    }
    /**
     NewEthereumClient connects a client to the given URL.
     - parameter path: Path
     */
    public init(path: String = "ws://10.0.2.2:8546") throws{
        var error: NSError? = nil
        let gethClient = GethNewEthereumClient(path, &error)
        guard error == nil else { throw(error!)}
        guard let client = gethClient else { throw(SwifthereumError.invalidPath) }
        _gethEthereumClient = client
    }
    
    /**
     CallContract executes a message call transaction, which is directly executed in the VM
     of the node, but never mined into the blockchain.
     
     blockNumber selects the block height at which the call runs. It can be <0, in which
     case the code is taken from the latest known block. Note that state from very old
     blocks might not be available.
     Original method: ```-(NSData*)callContract:(GethContext*)ctx msg:(GethCallMsg*)msg number:(int64_t)number error:(NSError**)error;```
     */
    open func call(message: Message, context: Context = .cancel, number: Int = 0) throws -> Data {
        return try _gethEthereumClient.callContract(context._gethContext, msg: message._callMsg, number: Int64(number))
    }
    
    /**
     EstimateGas tries to estimate the gas needed to execute a specific transaction based on
     the current pending state of the backend blockchain. There is no guarantee that this is
     the true gas limit requirement as other transactions may be added or removed by miners,
     but it should provide a basis for setting a reasonable default.
     
     Original method: ```-(GethBigInt*)estimateGas:(GethContext*)ctx msg:(GethCallMsg*)msg error:(NSError**)error;```
     */
    open func estimateGas(for message: Message, context: Context = .cancel) throws -> Gas {
        return try _gethEthereumClient.estimateGas(context._gethContext, msg: message._callMsg).getInt64()
    }
    
    /**
     FilterLogs executes a filter query.
     
     Original method: ```-(GethLogs*)filterLogs:(GethContext*)ctx query:(GethFilterQuery*)query error:(NSError**)error;```
     */
    open func filterLogs(query: FilterQuery, context: Context = .cancel) throws -> [Log] {
        return try _gethEthereumClient.filterLogs(context._gethContext, query: query._gethFilterQuery).arrays()
    }
    
    /**
     GetBalanceAt returns the wei balance of the given account.
     The block number can be <0, in which case the balance is taken from the latest known block.
     
     Original method: ```-(GethBigInt*)getBalanceAt:(GethContext*)ctx account:(GethAddress*)account number:(int64_t)number error:(NSError**)error;```
     */
    open func balance(for account: Address, token: ERC20Token? = nil, block: BlockNumber = -1, context: Context = .cancel) throws -> Wei {
        if let token = token {
            fatalError() // TODO:
        } else {
            let balance = try _gethEthereumClient.getBalanceAt(context._gethContext, account: account._gethAddress, number: block)
            return Wei(balance)
        }
    }
    
    /**
     GetBlockByHash returns the given full block.
     
     Original Method: ```-(GethBlock*)getBlockByHash:(GethContext*)ctx hash:(GethHash*)hash error:(NSError**)error;```
     */
    open func block(byHash hash: Hash, context: Context = .cancel) throws -> Block {
        let gethBlock = try _gethEthereumClient.getBlockByHash(context._gethContext, hash: hash._gethHash)
        return try Block(block: gethBlock)
    }
    
    /**
     GetBlockByNumber returns a block from the current canonical chain. If number is <0, the latest known block is returned.
     
     Orignal Method: ```- (GethBlock*)getBlockByNumber:(GethContext*)ctx number:(int64_t)number error:(NSError**)error;```
     */
    open func block(byNumber number: Int64, context: Context = .cancel) throws -> Block {
        let gethBlock = try _gethEthereumClient.getBlockByNumber(context._gethContext, number: number)
        return try Block(block: gethBlock)
    }
    
    /**
     * GetCodeAt returns the contract code of the given account.
     The block number can be <0, in which case the code is taken from the latest known block.
     */
    //- (NSData*)getCodeAt:(GethContext*)ctx account:(GethAddress*)account number:(int64_t)number error:(NSError**)error;
    /**
     * GetHeaderByHash returns the block header with the given hash.
     */
    //- (GethHeader*)getHeaderByHash:(GethContext*)ctx hash:(GethHash*)hash error:(NSError**)error;
    /**
     * GetHeaderByNumber returns a block header from the current canonical chain. If number is <0,
     the latest known header is returned.
     */
    //- (GethHeader*)getHeaderByNumber:(GethContext*)ctx number:(int64_t)number error:(NSError**)error;
    /**
     * GetNonceAt returns the account nonce of the given account.
     The block number can be <0, in which case the nonce is taken from the latest known block.
     */
    //- (BOOL)getNonceAt:(GethContext*)ctx account:(GethAddress*)account number:(int64_t)number nonce:(int64_t*)nonce error:(NSError**)error;
    /**
     GetPendingBalanceAt returns the wei balance of the given account in the pending state.
     Original method: ```- (GethBigInt*)getPendingBalanceAt:(GethContext*)ctx account:(GethAddress*)account error:(NSError**)error;```
     */
    open func pendingBalance(account: Address, context: Context = .cancel) throws -> Wei {
        return try Wei(_gethEthereumClient.getPendingBalance(at: context._gethContext, account: account._gethAddress))
    }
    
    
    /**
     GetPendingCodeAt returns the contract code of the given account in the pending state.
     - (NSData*)getPendingCodeAt:(GethContext*)ctx account:(GethAddress*)account error:(NSError**)error;
     */

    
    /**
     GetPendingStorageAt returns the value of key in the contract storage of the given account in the pending state.
     Original method: ```- (NSData*)getPendingStorageAt:(GethContext*)ctx account:(GethAddress*)account key:(GethHash*)key error:(NSError**)error;```
     */
//    open func
    
    
    /**
     GetPendingTransactionCount returns the total number of transactions in the pending state.
     Orignal method: ```- (BOOL)getPendingTransactionCount:(GethContext*)ctx count:(long*)count error:(NSError**)error;```
     */
//    open func pendingTransactionCoint
    
  
    
    
    /**
     GetTransactionCount returns the total number of transactions in the given block.
     Original method: ```- (BOOL)getTransactionCount:(GethContext*)ctx hash:(GethHash*)hash count:(long*)count error:(NSError**)error;```
     */
    open func transactionCountForBlock(_ hash: Hash, context: Context = .cancel) throws -> Int {
        var count: Int = 0
        try _gethEthereumClient.getTransactionCount(context._gethContext, hash: hash._gethHash, count: &count)
        return count
    }
    
    
    
    /**
     SyncProgress retrieves the current progress of the sync algorithm. If there's no sync currently running, it returns nil.
     Original method: -(GethSyncProgress*)syncProgress:(GethContext*)ctx error:(NSError**)error;
     */
    open func syncProgress(context: Context = .cancel) -> SyncProgress? {
        let progress = try? _gethEthereumClient.syncProgress(context._gethContext)
        return SyncProgress(progress: progress)
    }
}



/*
/**
 * GetPendingNonceAt returns the account nonce of the given account in the pending state.
 This is the nonce that should be used for the next transaction.
 */
- (BOOL)getPendingNonceAt:(GethContext*)ctx account:(GethAddress*)account nonce:(int64_t*)nonce error:(NSError**)error;

 /**
 GetStorageAt returns the value of key in the contract storage of the given account.
 The block number can be <0, in which case the value is taken from the latest known block.
 */
- (NSData*)getStorageAt:(GethContext*)ctx account:(GethAddress*)account key:(GethHash*)key number:(int64_t)number error:(NSError**)error;
/**
 * GetTransactionByHash returns the transaction with the given hash.
 */
- (GethTransaction*)getTransactionByHash:(GethContext*)ctx hash:(GethHash*)hash error:(NSError**)error;

/**
 * GetTransactionInBlock returns a single transaction at index in the given block.
 */
- (GethTransaction*)getTransactionInBlock:(GethContext*)ctx hash:(GethHash*)hash index:(long)index error:(NSError**)error;
/**
 * GetTransactionReceipt returns the receipt of a transaction by transaction hash.
 Note that the receipt is not available for pending transactions.
 */
- (GethReceipt*)getTransactionReceipt:(GethContext*)ctx hash:(GethHash*)hash error:(NSError**)error;
/**
 * PendingCallContract executes a message call transaction using the EVM.
 The state seen by the contract call is the pending state.
 */
- (NSData*)pendingCallContract:(GethContext*)ctx msg:(GethCallMsg*)msg error:(NSError**)error;
/**
 * SendTransaction injects a signed transaction into the pending pool for execution.
 
 If the transaction was a contract creation use the TransactionReceipt method to get the
 contract address after the transaction has been mined.
 */
- (BOOL)sendTransaction:(GethContext*)ctx tx:(GethTransaction*)tx error:(NSError**)error;
/**
 * SubscribeFilterLogs subscribes to the results of a streaming filter query.
 */
- (GethSubscription*)subscribeFilterLogs:(GethContext*)ctx query:(GethFilterQuery*)query handler:(id<GethFilterLogsHandler>)handler buffer:(long)buffer error:(NSError**)error;
/**
 * SubscribeNewHead subscribes to notifications about the current blockchain head
 on the given channel.
 */
- (GethSubscription*)subscribeNewHead:(GethContext*)ctx handler:(id<GethNewHeadHandler>)handler buffer:(long)buffer error:(NSError**)error;
/**
 * SuggestGasPrice retrieves the currently suggested gas price to allow a timely
 execution of a transaction.
 */
- (GethBigInt*)suggestGasPrice:(GethContext*)ctx error:(NSError**)error;
/**
 * SyncProgress retrieves the current progress of the sync algorithm. If there's
 no sync currently running, it returns nil.
 */
- (GethSyncProgress*)syncProgress:(GethContext*)ctx error:(NSError**)error;
@end
*/
