//
//  Resource+Web3.swift
//  BigInt
//
//  Created by Ronald Mannak on 12/1/17.
//

import Foundation

extension Resource {
    
    /**
     Initializer for Web3 calls
     */
    public init(server: Server, method: Web3Method, id: Int = 1) throws {
        let parameters = try method.requestDictionary(id: id)
        self.init(server: server, parameters: parameters)
    }
}
