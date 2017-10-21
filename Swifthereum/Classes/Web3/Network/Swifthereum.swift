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
            let resource = Resource<A>(server: server, method: method)
            NetworkService().load(resource: resource, debug: true) { result in
//            let resource = Resource<Web3Result>(server: server, method: method)
//            NetworkService().load(resource: resource, debug: true) { (result: Result<Web3Result>) in
                
                // Convert result?
                completion(result)
            }
        default:
            fatalError("Only web3 is currentl supported")
        }
    }    
}
