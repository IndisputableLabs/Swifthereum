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
    public func gasPrice(completion: @escaping (Result<Wei>) -> ()) {
        fetch(method: .gasPrice) { (result: Result<Wei>) in
            completion(result)
        }
    }
    
    /**
     https://github.com/ethereum/wiki/wiki/JSON-RPC#eth_accounts
     */
    public func accounts(completion: @escaping (Result<[Account]>) -> ()) {
        fetch(method: .accounts) { (result: Result<[Account]>) in
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
    public func balance(for address: Address, defaultBlock: DefaultBlock = .latest, completion: @escaping (Result<String>) -> ()) {
        let method = Method.balance(address, defaultBlock)
        fetch(method: method) { (result: Result<String>) in
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
}
