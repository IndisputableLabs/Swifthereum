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
    case blockTransactionCount(BlockHash)
    case blockTransactionCountByNumber(Int64)
    case uncleCount(BlockHash)
    case uncleCountByBlockNumber(Int64)
    case code(Address, DefaultBlock)
    case sign(Address, String)
    case sendTransaction(NewTransaction)
    case sendRawTransaction(TransactionHash)
    case call(NewTransaction)
    case estimateGas(NewTransaction)
    case blockByHash(BlockHash)
    case blockByNumber(Int64)
    case transaction(TransactionHash)
    case transactionByBlockHashAndIndex(BlockHash, Int)
    case transactionByBlockNumberAndIndex(Int64, Int)
    case receipt(TransactionHash)
    case uncleByBlockHashAndIndex(BlockHash, Int)
    case uncleByBlockNumberAndIndex(Int, Int)
    case compilers
    case compileSolidity(String)
    case compileLLL(String)
    case compileSerpent(String)
    case notification(EthereumNotification)
    case newBlockNotification
    case newPendingTransactionNotification
    case uninstallNotification(Int64)
    case notificationChanges(Int64)
    case notificationLogs(Int64)
    case logs(EthereumNotification)
    case work
    case submitWork(Work)
    case submitHashrate(Bytes32Hash, Bytes32Hash)
    
    // DB
    case putString(String, String, String)
    case getString(String, String)
    case putHex(String, String, String)
    case getHex(String, String)
    
    // SSH
    case sshPost
    case sshVersion
    case sshNewIdentity
    case sshHasIdentiy
    case sshNewGroup
    case sshAddToGroup
    case sshNewFilter
    case sshUninstallFilter
    case sshGetFilterChanges
    case sshGetMessages
}

extension Method {
    public var method: String {
        switch self {
        case .clientVersion:                    return "web3_clientVersion"
        case .sha3:                             return "web3_sha3"
        case .networkID:                        return "net_version"
        case .peerCount:                        return "net_peerCount"
        case .listening:                        return "net_listening"
        case .protocolVersion:                  return "eth_protocolVersion"
        case .isSyncing:                        return "eth_syncing"
        case .coinbase:                         return "eth_coinbase"
        case .isMining:                         return "eth_mining"
        case .hashrate:                         return "eth_hashrate"
        case .gasPrice:                         return "eth_gasPrice"
        case .accounts:                         return "eth_accounts"
        case .blockNumber:                      return "eth_blockNumber"
        case .balance:                          return "eth_getBalance"
        case .storage:                          return "eth_getStorageAt"
        case .transactionCount:                 return "eth_getTransactionCount"
        case .blockTransactionCount:            return "eth_getBlockTransactionCountByHash"
        case .blockTransactionCountByNumber:    return "eth_getBlockTransactionCountByNumber"
        case .uncleCount:                       return "eth_getUncleCountByBlockHash"
        case .uncleCountByBlockNumber:          return "eth_getUncleCountByBlockNumber"
        case .code:                             return "eth_getCode"
        case .sign:                             return "eth_sign"
        case .sendTransaction:                  return "eth_sendTransaction"
        case .sendRawTransaction:               return "eth_sendRawTransaction"
        case .call:                             return "eth_call"
        case .estimateGas:                      return "eth_estimateGas"
        case .blockByHash:                      return "eth_getBlockByHash"
        case .blockByNumber:                    return "eth_getBlockByNumber"
        case .transaction:                      return "eth_getTransactionByHash"
        case .transactionByBlockHashAndIndex:   return "eth_getTransactionByBlockHashAndIndex"
        case .transactionByBlockNumberAndIndex: return "eth_getTransactionByBlockNumberAndIndex"
        case .receipt:                          return "eth_getTransactionReceipt"
        case .uncleByBlockHashAndIndex:         return "eth_getUncleByBlockHashAndIndex"
        case .uncleByBlockNumberAndIndex:       return "eth_getUncleByBlockNumberAndIndex"
        case .compilers:                        return "eth_getCompilers"
        case .compileSolidity:                  return "eth_compileSolidity"
        case .compileLLL:                       return "eth_compileLLL"
        case .compileSerpent:                   return "eth_compileSerpent"
        case .notification:                     return "eth_newFilter"
        case .newBlockNotification:             return "eth_newBlockFilter"
        case .newPendingTransactionNotification:return "eth_newPendingTransactionFilter"
        case .uninstallNotification:            return "eth_uninstallFilter"
        case .notificationChanges:           return "eth_getFilterChanges"
        case .notificationLogs:              return "eth_getFilterLogs"
        case .logs:                          return "eth_getLogs"
        case .work:                          return "eth_getWork"
        case .submitWork:                       return "eth_submitWork"
        case .submitHashrate:                   return "eth_submitHashrate"
        case .putString:                        return "db_putString"
        case .getString:                        return "db_getString"
        case .putHex:                           return "db_putHex"
        case .getHex:                           return "db_getHex"
        case .sshPost:                          return "shh_post"
        case .sshVersion:                       return "shh_version"
        case .sshNewIdentity:                   return "shh_newIdentity"
        case .sshHasIdentiy:                    return "shh_hasIdentity"
        case .sshNewGroup:                      return "shh_newGroup"
        case .sshAddToGroup:                    return "shh_addToGroup"
        case .sshNewFilter:                     return "shh_newFilter"
        case .sshUninstallFilter:               return "shh_uninstallFilter"
        case .sshGetFilterChanges:              return "shh_getFilterChanges"
        case .sshGetMessages:                   return "shh_getMessages"
        }
    }
}

extension Method {
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
        case .blockTransactionCount(let blockHash):
            return String(describing: blockHash)
        case .blockTransactionCountByNumber(let number):
            return "\(number)"
        case .uncleCount(let blockHash):
            return String(describing: blockHash)
        case .uncleCountByBlockNumber(let number):
            return "\(number)"
//        case .code(let address, let defaultBlock):
//            return
            
            
            
            
//        case .sendTransaction(let transaction):
//            let encoder = JSONEncoder()
//            return try? encoder.encode(transaction)
        case .transaction(let hash):
            return [String(describing: hash)]
        default:
            return nil
        }
    }
}

/*
case code(Address, DefaultBlock)
case sign(Address, String)
case sendTransaction(NewTransaction)
case sendRawTransaction(TransactionHash)
case call(NewTransaction)
case estimateGas(NewTransaction)
case blockByHash(BlockHash)
case blockByNumber(Int64)
case transaction(TransactionHash)
case transactionByBlockHashAndIndex(BlockHash, Int)
case transactionByBlockNumberAndIndex(Int64, Int)
case receipt(TransactionHash)
case uncleByBlockHashAndIndex(BlockHash, Int)
case uncleByBlockNumberAndIndex(Int, Int)
case compilers
case compileSolidity(String)
case compileLLL(String)
case compileSerpent(String)
case notification(EthereumNotification)
case newBlockNotification
case newPendingTransactionNotification
case uninstallNotification(Int64)
case notificationChanges(Int64)
case notificationLogs(Int64)
case logs(EthereumNotification)
case work
case submitWork(Work)
case submitHashrate(Bytes32Hash, Bytes32Hash)
*/
