//
//  Method.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/19/17.
//

import Foundation

/**
 https://github.com/ethereum/wiki/wiki/JSON-RPC
 */
public enum Method {
    
    // Web3
    case clientVersion
    case sha3(String) // TODO: Change to variable length Hash
    
    // Net
    case networkID
    case peerCount
    case listening
    
    // Ethereum
    case protocolVersion
    case isSyncing
    case coinbase
    case isMining
    case hashrate
    case gasPrice
    case accounts
    case blockNumber
    case balance(Address, DefaultBlock)
    case storage(Address, DefaultBlock)
    case transactionCount(Address, DefaultBlock)
    /*eth_getBlockTransactionCountByHash
    eth_getBlockTransactionCountByNumber
    eth_getUncleCountByBlockHash
    eth_getUncleCountByBlockNumber
    eth_getCode
    eth_sign */
    case sendTransaction(NewTransaction)
    case sendRawTransaction
    case call
    case estimateGas
    case blockByHash
    case blockByNumber
    case transactionByHash(TransactionHash)
    case transactionByBlockHashAndIndex
    case transactionByBlockNumberAndIndex
 
    public var method: String {
        switch self {
        case .clientVersion:    return "web3_clientVersion"
        case .sha3:             return "web3_sha3"
        case .networkID:        return "net_version"
        case .peerCount:        return "net_peerCount"
        case .listening:        return "net_listening"
        case .protocolVersion:  return "eth_protocolVersion"
        case .isSyncing:          return "eth_syncing"
        case .coinbase:         return "eth_coinbase"
        case .isMining:           return "eth_mining"
        case .hashrate:         return "eth_hashrate"
        case .gasPrice:         return "eth_gasPrice"
        case .accounts:         return "eth_accounts"
        case .blockNumber:      return "eth_blockNumber"
        case .balance:          return "eth_getBalance"
        case .storage:          return "eth_getStorageAt"
        case .transactionCount: return "eth_getTransactionCount"
        /*eth_getBlockTransactionCountByHash
        eth_getBlockTransactionCountByNumber
        eth_getUncleCountByBlockHash
        eth_getUncleCountByBlockNumber
        eth_getCode
        eth_sign */
        case .sendTransaction:  return "eth_sendTransaction"
        case .sendRawTransaction:   return "eth_sendRawTransaction"
        case .call:             return "eth_call"
        case .estimateGas:      return "eth_estimateGas"
        case .blockByHash:      return "eth_getBlockByHash"
        case .blockByNumber:    return "eth_getBlockByNumber"
        case .transactionByHash:    return "eth_getTransactionByHash"
        case .transactionByBlockHashAndIndex:   return "eth_getTransactionByBlockHashAndIndex"
        case .transactionByBlockNumberAndIndex: return "eth_getTransactionByBlockNumberAndIndex"
        }
    }
    
    public var parameters: Decodable? {
        switch self {
        case .sha3(let string):
            return [string]
        case .balance(let address, let defaultBlock):
            return [String(describing: address), defaultBlock.value]
        case .storage(let address, let defaultBlock):
            return [String(describing: address), defaultBlock.value]
        case .transactionCount(let address, let defaultBlock):
            return [String(describing: address), defaultBlock.value]
        case .sendTransaction(let transaction):
            let encoder = JSONEncoder()
            return try? encoder.encode(transaction)
        case .transactionByHash(let hash):
            return [String(describing: hash)]
        default:
            return nil
        }
    }
    
/*


eth_getTransactionReceipt
eth_getUncleByBlockHashAndIndex
eth_getUncleByBlockNumberAndIndex
eth_getCompilers
eth_compileLLL
eth_compileSolidity
eth_compileSerpent
eth_newFilter
eth_newBlockFilter
eth_newPendingTransactionFilter
eth_uninstallFilter
eth_getFilterChanges
eth_getFilterLogs
eth_getLogs
eth_getWork
eth_submitWork
eth_submitHashrate
db_putString
db_getString
db_putHex
db_getHex
shh_post
shh_version
shh_newIdentity
shh_hasIdentity
shh_newGroup
shh_addToGroup
shh_newFilter
shh_uninstallFilter
shh_getFilterChanges
shh_getMessages
*/
}
