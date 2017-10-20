//
//  Address.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/18/17.
//

import Foundation
import BigInt

public struct Address: Codable {
    public let hash: String
    
    public init?(hash: String) {
        let hashLength = 40
        guard let hash = String(hex: hash, length: hashLength) else { return nil }
        self.hash = hash
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
}

extension Address: CustomStringConvertible {
    public var description: String {
        return hash
    }
}

// TODO:
// Do we need the Swifthereum and Provider classes? or can we just pass a Server to all methods?
// Do we need a generic fetch method in Swifthereum?
// Can the Method enum return the correct Resource<ResultType> type?
