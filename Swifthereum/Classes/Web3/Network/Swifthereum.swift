//
//  Swifthereum.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/19/17.
//

import Foundation
import BigInt

public class Swifthereum {
    
    public static let version = "1.0.0" // Web3 version
    
    public let provider: Provider
    
    public init(provider: Provider) {
        self.provider = provider
    }
    
    public func fetch<A: Decodable>(method: Method, completion: @escaping (Result<A>) -> ()) {
        switch provider {
        case .web3(let server):
            let resource = Resource<Web3Result<A>>(server: server, method: method)
            NetworkService().load(resource: resource, debug: true) { result in
                
                /*
                 Ethereum wraps both errors and successful results in a JSON reply message.
                 A successful result could be: {"jsonrpc":"2.0","id":61,"result":"1"}
                 An error looks like this: {"jsonrpc":"2.0","id":1,"error":{"code":-32602,"message":"eth_GetTransactionByHash expects 1 parameters, got 0"}}
                 No HTTP error codes are sent by Ethereum.
                 
                 Web3Result is a wrapper for the top level Ethereum reply with an optional error and optional result property.
                 The Web3Result is manually parsed and the result or error wrapped in a Result<A>
                 */
                
                switch result {
                case .data(let web3Result):
                    // Filter out embedded Ethereum error message, if present
                    if let errorMessage = web3Result.error {
                        let error = SwifthereumError.serverError(errorMessage.code, errorMessage.message)
                        print("error: \(errorMessage)")
                        completion(Result<A>.error(error))
                    } else if let result = web3Result.result {
                        print("Result: \(result)")
                        completion(Result<A>.data(result))                        
                    } else {
                        fallthrough
                    }
                case .noData:
                    completion(Result<A>.noData)
                case .error(let error):
                    // Pass through Cocoa error
                    completion(Result<A>.error(error))
                }
            }
        default:
            fatalError("Only web3 is currently supported")
        }
    }    
}

/*
 *  Web3 JSON RCP Interface
 */
extension Swifthereum {
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#web3_clientversion
     */
    public func clientVersion(completion: @escaping (Result<String>) -> ()) {
        fetch(method: .clientVersion) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#web3_sha3
     */
//    public func sha3(hex: Hash, completion: @escaping (Result<Hash>) -> ()) {
//        fetch(method: .sha3(hex) { (result: Result<String>) in
//            completion(result)
//        }
//    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#net_version
     */
//    public func networkID(completion: @escaping (Result<NetworkID>) -> ()) {
//        fetch(method: .networkID) { (result: Result<NetworkID>) in
//            completion(result)
//        }
//    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#net_listening
     */
    public func networkID(completion: @escaping (Result<Bool>) -> ()) {
        fetch(method: .listening) { (result: Result<Bool>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#net_peercount
     */
    public func peerCount(completion: @escaping (Result<Int>) -> ()) {
        fetch(method: .peerCount) { (result: Result<Int>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_protocolversion
     */
    public func protocolVersion(completion: @escaping (Result<String>) -> ()) {
        fetch(method: .protocolVersion) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_syncing
     */
//    public func isSyncing(completion: @escaping (Result<Sync>) -> ()) {
//        fetch(method: .syncing) { (result: Result<Sync>) in
//            completion(result)
//        }
//    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_coinbase
     */
    public func coinbase(completion: @escaping (Result<Address>) -> ()) {
        fetch(method: .coinbase) { (result: Result<Address>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_mining
     */
    public func isMining(completion: @escaping (Result<Bool>) -> ()) {
        fetch(method: .isMining) { (result: Result<Bool>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_hashrate
     */
    public func hashrate(completion: @escaping (Result<Int>) -> ()) {
        fetch(method: .hashrate) { (result: Result<Int>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_gasprice
     */
    public func gasPrice(completion: @escaping (Result<String>) -> ()) {
        fetch(method: .gasPrice) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_accounts
     */
    public func accounts(completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .accounts) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_blocknumber
     */
    public func latestBlock(completion: @escaping (Result<BigInt>) -> ()) {
        fetch(method: .blockNumber) { (result: Result<BigInt>) in
            completion(result)
        }
    }
    
    /**
     Returns the balance of the account of given address.
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getbalance
     TODO: Change back to BigInt. Issue is that result is hex ("0x317604574664c00")
     */
    public func balance(for address: Address, defaultBlock: DefaultBlock = .latest, completion: @escaping (Result<Wei>) -> ()) {
        let method = Method.balance(address, defaultBlock)
        fetch(method: method) { (result: Result<Wei>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getstorageat
     */
    public func storage(at address: Address, defaultBlock: DefaultBlock = .latest, completion: @escaping (Result<String>) -> ()) {
        fetch(method: .storage(address, defaultBlock)) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_gettransactioncount
     */
    public func transactionCount(at address: Address, defaultBlock: DefaultBlock, completion: @escaping (Result<String>) ->()) {
        fetch(method: .transactionCount(address, defaultBlock)) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getblocktransactioncountbyhash
     */
    public func blockTransactionCount(by hash: BlockHash, completion: @escaping (Result<String>) -> ()) {
        fetch(method: .blockTransactionCount(hash)) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getblocktransactioncountbynumber
     */
    public func blockTransactionCount(by number: Int64, completion: @escaping (Result<String>) -> ()) {
        fetch(method: .blockTransactionCountByNumber(number)) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getunclecountbyblockhash
     */
    public func uncleCount(by hash: BlockHash, completion: @escaping (Result<String>) -> ()) {
        fetch(method: .uncleCount(hash)) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getunclecountbyblocknumber
     */
    public func uncleCount(by blockNumber: Int64, completion: @escaping (Result<String>) -> ()) {
        fetch(method: .uncleCountByBlockNumber(blockNumber)) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getcode
     */
    public func code(address: Address, defaultBlock: DefaultBlock, completion: @escaping (Result<String>) -> ()) {
        fetch(method: .code(address, defaultBlock)) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_sign
     */
    public func sign(address: Address, message: String, completion: @escaping (Result<String>) -> ()) {
        fetch(method: .sign(address, message)) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_sendtransaction
     */
    public func send(transaction: NewTransaction, completion: @escaping (Result<TransactionHash>) -> ()) {
        fetch(method: .sendTransaction(transaction)) { (result: Result<TransactionHash>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_sendrawtransaction
     */
    public func send(rawTransaction: TransactionHash, completion: @escaping (Result<TransactionHash>) -> ()) {
        fetch(method: .sendRawTransaction(rawTransaction)) { (result: Result<TransactionHash>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_call
     */
    public func call(transaction: NewTransaction, completion: @escaping (Result<TransactionHash>) -> ()) {
        fetch(method: .call(transaction)) { (result: Result<TransactionHash>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_estimategas
     */
    public func estimateGas(for transaction: NewTransaction, completion: @escaping (Result<String>) -> ()) {
        fetch(method: .estimateGas(transaction)) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getblockbyhash
     */
    public func block(by hash: BlockHash, completion: @escaping (Result<String>) -> ()) { // Block
        fetch(method: .blockByHash(hash)) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getblockbynumber
     */
    public func block(by number: Int64, completion: @escaping (Result<String>) -> ()) {
        fetch(method: .blockByNumber(number)) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_gettransactionbyhash
     */
    public func transaction(hash: TransactionHash, completion: @escaping (Result<Transaction>) -> ()) {
        fetch(method: .transaction(hash)) { (result: Result<Transaction>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_gettransactionbyblockhashandindex
     */
    public func transaction(blockHash: BlockHash, index: Int, completion: @escaping (Result<Transaction>) -> ()) {
        fetch(method: .transactionByBlockHashAndIndex(blockHash, index)) { (result: Result<Transaction>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_gettransactionbyblocknumberandindex
     */
    public func transaction(blockNumber: Int64, index: Int, completion: @escaping (Result<Transaction>) -> ()) {
        fetch(method: .transactionByBlockNumberAndIndex(blockNumber, index)) { (result: Result<Transaction>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_gettransactionreceipt
     */
    public func receipt(hash: TransactionHash, completion: @escaping (Result<Transaction>) -> ()) {
        fetch(method: .receipt(hash)) { (result: Result<Transaction>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getunclebyblockhashandindex
     */
    public func uncle(by blockHash: BlockHash, index: Int, completion: @escaping (Result<String>) -> ()) { // Block
        fetch(method: .uncleByBlockHashAndIndex(blockHash, index)) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getunclebyblocknumberandindex
     */
    public func uncle(by blockNumber: Int, index: Int, completion: @escaping (Result<String>) -> ()) { // Block
        fetch(method: .uncleByBlockNumberAndIndex(blockNumber, index)) { (result: Result<String>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getcompilers
     */
    public func compilers(completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .compilers) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_compilesolidity
     */
    public func compile(solidity: String, completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .compileSolidity(solidity)) { (result: Result<[String]>) in
            completion(result)
        }
    }

    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_compilelll
     */
    public func compile(lll: String, completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .compileLLL(lll)) { (result: Result<[String]>) in
            completion(result)
        }
    }

    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_compileserpent
     */
    public func compile(serpent: String, completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .compileSerpent(serpent)) { (result: Result<[String]>) in
            completion(result)
        }
    }

    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_newfilter
     */
    public func notification(notification: EthereumNotification, completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .notification(notification)) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_newblockfilter
     */
    public func newBlockNotification(completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .newBlockNotification) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_newpendingtransactionfilter
     */
    public func newPendingTransactionNotification(completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .newPendingTransactionNotification) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_uninstallfilter
     */
    public func uninstallNotification(id: Int64, completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .uninstallNotification(id)) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getfilterchanges
     */
    public func notificationChanges(id: Int64, completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .notificationChanges(id)) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getfilterlogs
     */
    public func notificationLogs(id: Int64, completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .notificationLogs(id)) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getlogs
     */
    public func logs(notification: EthereumNotification, completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .logs(notification)) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_getwork
     */
    public func work(completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .work) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_submitwork
     */
    public func submitWork(work: Work, completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .submitWork(work)) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_submithashrate
     */
    public func submitHashrate(hashrate: Bytes32Hash, id: Bytes32Hash, completion: @escaping (Result<[Bool]>) -> ()) {
        fetch(method: .submitHashrate(hashrate, id)) { (result: Result<[Bool]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#db_putstring
     */
    @available(*, deprecated)
    public func putString(db: String, key: String, value: String, completion: @escaping (Result<[Bool]>) -> ()) {
        fetch(method: .putString(db, key, value)) { (result: Result<[Bool]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#db_getstring
     */
    @available(*, deprecated)
    public func getString(db: String, key: String, completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .getString(db, key)) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#db_puthex
     */
    @available(*, deprecated)
    public func putHex(db: String, key: String, value: String, completion: @escaping (Result<[Bool]>) -> ()) {
        fetch(method: .putHex(db, key, value)) { (result: Result<[Bool]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#db_gethex
     */
    @available(*, deprecated)
    public func getHex(db: String, key: String, completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .getHex(db, key)) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#shh_version
     */
    public func sshVersion(completion: @escaping (Result<[String]>) -> ()) {
        fetch(method: .sshVersion) { (result: Result<[String]>) in
            completion(result)
        }
    }
    
    // TODO: add last methods
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#shh_post
     */
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#shh_newidentity
     */
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#shh_hasidentity
     */
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#shh_newgroup
     */
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#shh_addtogroup
     */
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#shh_newfilter
     */
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#shh_uninstallfilter
     */
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#shh_getfilterchanges
     */
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#shh_getmessages
     */
}
