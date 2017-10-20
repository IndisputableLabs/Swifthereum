//
//  Address.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/18/17.
//

import Foundation
import BigInt

public struct Address: Hash {
    public let hash: HashString
    
    public static var hashLength: Int = 40
    
    public init?(hex: HashString) {
        guard let hash = String(hex: hex, length: type(of: self).hashLength) else { return nil }
        self.hash = hash
    }
}

extension Address {
    /**
     Returns the balance of the account of given address.
     */
    public func balance(swifthereum: Swifthereum, defaultBlock: DefaultBlock = .latest, completion: @escaping (Result<Web3Result>) -> ()) {
        let method = Method.balance(self, defaultBlock)
        let resource = Resource<Web3Result>(server: Server(), method: method)
        NetworkService().load(resource: resource, debug: true) { result in
            completion(result)
        }
    }
}

// TODO:
// Do we need the Swifthereum and Provider classes? or can we just pass a Server to all methods?
// Do we need a generic fetch method in Swifthereum?
// Can the Method enum return the correct Resource<ResultType> type?
// What if we make this a Hash class with Address and other hashes like TransactionHash and privateKeyHash as subclasses? Only difference is the length of the hash
// Or a Hash protocol with default n swift the protocol can be generic if you will use associatedtype.

