//
//  Server.swift
//  Crisp
//
//  Created by Ronald Mannak on 1/11/17.
//  Copyright © 2017 A Puzzle A Day. All rights reserved.
//

import Foundation

public struct Server {
    
    public let domain: String      // E.g. "http://localhost:8545"
    public var headers: JSONDictionary? = nil
    public var defaultParameters: JSONDictionary = ["jsonrpc" : "2.0", "id": 1]
}


extension Server {
    /**
     Initializes domain to default localhost.
     
     Initializer located in extension, so we don't override the default initializer 
     */
    public init(domain: String = "http://localhost:8545") {
        self.domain = domain
    }
}


