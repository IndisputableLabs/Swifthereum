//
//  Web3Endpoint.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/25/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation


/**
 
 See (https://github.com/ethereum/wiki/wiki/JSON-RPC#web3_clientversion)
 *//*
enum Web3Endpoints {

    // let for TestRPC or Geth
    
    /**
     BlockParameter is the Default Block Parameter used in eth_getBalance, eth_getCode, eth_getTransactionCount, eth_getStorageAt, and eth_call calls
     */
    enum BlockParameter {
        case blockNumber(String)
        case earliest, latest, pending
        
        var rawValue: String {
            switch self {
            case .blockNumber(let string):
                return string
            case .earliest:
                return "earliest"
            case .latest:
                return "latest"
            case .pending:
                return "pending"
            }
        }
    }
    
    case getStorageAt(data: String, quantity: Int, blockParameter: BlockParameter)
    case eth_sendTransaction
    
    var parameters: JSONDictionary {
        let method = "method"
        let params = "params"
        switch self {
        case .getStorageAt(let data, let quantity, let blockParameter):
            return [method: "eth_getStorageAt", params: [data, quantity, blockParameter]]
        }
    }
    
    
    
} */



/*
 TestRPC supported: https://github.com/ethereumjs/testrpc
eth_accounts
eth_blockNumber
eth_call
eth_coinbase
eth_estimateGas
eth_gasPrice
eth_getBalance
eth_getBlockByNumber
eth_getBlockByHash
eth_getBlockTransactionCountByHash
eth_getBlockTransactionCountByNumber
eth_getCode (only supports block number “latest”)
eth_getCompilers
eth_getFilterChanges
eth_getFilterLogs
eth_getLogs
eth_getStorageAt
eth_getTransactionByHash
eth_getTransactionByBlockHashAndIndex
eth_getTransactionByBlockNumberAndIndex
eth_getTransactionCount
eth_getTransactionReceipt
eth_hashrate
eth_mining
eth_newBlockFilter
eth_newFilter (includes log/event filters)
eth_sendTransaction
eth_sendRawTransaction
eth_sign
eth_syncing
eth_uninstallFilter
debug_traceTransaction
net_listening
net_peerCount
net_version
miner_start
miner_stop
rpc_modules
web3_clientVersion
web3_sha3

plus some not supported by Geth:
 evm_snapshot
 evm_revert
 evm_increaseTime
 evm_mine
*/
