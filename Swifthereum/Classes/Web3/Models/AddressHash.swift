//
//  AddressHash.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/18/17.
//

import Foundation
import BigInt

public typealias AddressHash = String

extension AddressHash {
    
    ///
    public init?(address: String) {
        let hashLength = 40
        self.init(hex: address, length: hashLength)
    }
    
    /**
     Returns the balance of the account of given address.
     */
    public func balance(swifthereum: Swifthereum, defaultBlock: DefaultBlock = .latest, completion: @escaping (Result<Web3Result>) -> ()) {
        let method = Method.balance(self, defaultBlock)
        let resource = Resource<Web3Result>(server: Server(), method: method)
        NetworkService().load(resource: resource) { result in
            completion(result)
        }
    }
    
    // TODO:
    // Do we need the Swifthereum and Provider classes? or can we just pass a Server to all methods?
    // Do we need a generic fetch method in Swifthereum?
    // Can the Method enum return the correct Resource<ResultType> type?
    // Should me convert AddressHash into a struct? let address: AddressHash = "0x1234" does not validate the address
}

struct AddressHash2: Codable {
    public let address: String
    
    public init?(address: String) {
        let hashLength = 40
        guard let address = String(hex: address, length: hashLength) else { return nil }
        self.address = address
    }
    
    /**
     Returns the balance of the account of given address.
     */
    public func balance(swifthereum: Swifthereum, defaultBlock: DefaultBlock = .latest, completion: @escaping (Result<Web3Result>) -> ()) {
        let method = Method.balance(address, defaultBlock)
        let resource = Resource<Web3Result>(server: Server(), method: method)
        NetworkService().load(resource: resource) { result in
            completion(result)
        }
    }
}

