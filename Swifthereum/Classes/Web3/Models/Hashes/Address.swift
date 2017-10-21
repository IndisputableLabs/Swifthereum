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
        swifthereum.fetch(method: method) { (result: Result<Web3Result>) in
            completion(result)
        }
    }
}
