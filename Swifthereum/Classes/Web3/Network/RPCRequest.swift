//
//  RPCRequest.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/24/17.
//  Copyright © 2017 Indisputable Labs. All rights reserved.
//

import Foundation

infix operator ∆

//typealias RPCDict = [String : Codable]

/**
 JSON-RPC data structure
 
 For example: ```Rpc(method: "web3_clientVersion")``` will create the RPC data structure equivalent of ```{"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":0}```

 curl -X POST --data '{"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":0}'

 Further reading:
 - http://www.jsonrpc.org/specification
 - https://en.wikipedia.org/wiki/JSON-RPC
 */
public struct RPCRequest: Codable  {
    
    /// JSON RPC version, must be "2.0"
    public let jsonrpc = "2.0"
    
    /// RPC method, e.g. "web3_clientVersion"
    public let method: String
    
    /// parameters in either an array (byPosition, e.g. "[]") or dictionary (byName)
    public let params: RPCParameters
    
    /// id is returned in the corresponding response object. Can be set to any integer
    public let id: Int
    
    /**
     returns the full RPC dictionary (e.g. ["jsonrpc": 2.0, "method": ...])
     */
    public var dictionary: JSONDictionary {        
        return [
            "jsonrpc" : jsonrpc,
            "method" :  method,
            "params" :  params.parametersValue(),
            "id" :      id,
        ]
    }
}

extension RPCRequest {
    
    /// Initializer for byPosition parameters
    public init(method: String, params: ParamsByPosition? = nil, id: Int = 0) {
        self.init(method: method, params: RPCParameters(byPosition: params), id: id)
    }
    
    // Initializer for byName parameters
    public init(method: String, params: JSONDictionary? = nil, id: Int = 0) {
        self.init(method: method, params: RPCParameters(byName: params), id: id)
    }
}


// See https://medium.com/@hllmandel/codable-enum-with-associated-values-swift-4-e7d75d6f4370
extension RPCRequest: Equatable {
    
    public static func == (lhs: RPCRequest, rhs: RPCRequest) -> Bool {
        return
            lhs.params ==? rhs.params &&
            lhs.jsonrpc == rhs.jsonrpc &&
            lhs.method == rhs.method &&
            lhs.params ==? rhs.params
    }
    
    /**
     Returns Delta / Difference between two Rpc structs in human readable string format.
     Used in unit tests.
     */
    public static func ∆ (lhs: RPCRequest, rhs: RPCRequest) -> String? {
        guard lhs != rhs else { return nil }
        var string = "Delta: "
        if lhs.jsonrpc != rhs.jsonrpc {
            string = string + "\(lhs.jsonrpc) != \(rhs.jsonrpc) "
        }
        if lhs.method != rhs.method {
            string = string + "\(lhs.method) != \(rhs.method) "
        }
        if !(lhs.params ==? rhs.params) {
            string = string + "\(lhs.params.description) != \(rhs.params.description)"
        }

        return string
    }
}

