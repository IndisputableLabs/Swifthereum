//
//  Swifthereum.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/19/17.
//

import Foundation

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
