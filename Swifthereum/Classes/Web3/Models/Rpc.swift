//
//  Rpc.swift
//  UnitTests
//
//  Created by Ronald Mannak on 10/24/17.
//  Copyright © 2017 Indisputable Labs. All rights reserved.
//

import Foundation

infix operator ∆

// TODO: Change back to Codable
public typealias ParamsByName = [String: String] // [String: Codable]
public typealias ParamsByPosition = [String] //[Codable]

/**
 JSON-RPC data structure
 
 For example: ```Rpc(method: "web3_clientVersion")``` will create the RPC data structure equivalent of ```{"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":0}```

 curl -X POST --data '{"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":0}'

 Further reading:
 - http://www.jsonrpc.org/specification
 - https://en.wikipedia.org/wiki/JSON-RPC
 */
public struct Rpc: Codable {
    
    /// JSON RPC version, must be "2.0"
    public let jsonrpc = "2.0"
    
    /// RPC method, e.g. "web3_clientVersion"
    public let method: String
    
    /// parameters in either an array (byPosition, e.g. "[]") or dictionary (byName)
    public let params: RpcParams?
    
    /// id is returned in the corresponding response object. Can be set to any integer
    public let id: Int
}

extension Rpc {
    
    /// Initializer for byPosition parameters
    public init(method: String, params: ParamsByPosition? = nil, id: Int = 0) {
        let p: ParamsByPosition? = params ?? nil
        self.init(method: method, params: p, id: id)
    }
    
    // Initializer for byName parameters
    public init(method: String, params: ParamsByName? = nil, id: Int = 0) {
        let p: ParamsByName? = params ?? nil
        self.init(method: method, params: p, id: id)
    }
}


// See https://medium.com/@hllmandel/codable-enum-with-associated-values-swift-4-e7d75d6f4370
extension Rpc: Equatable {
    
    public static func == (lhs: Rpc, rhs: Rpc) -> Bool {
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
    public static func ∆ (lhs: Rpc, rhs: Rpc) -> String? {
        guard lhs != rhs else { return nil }
        var string = "Delta: "
        if lhs.jsonrpc != rhs.jsonrpc {
            string = string + "\(lhs.jsonrpc) != \(rhs.jsonrpc) "
        }
        if lhs.method != rhs.method {
            string = string + "\(lhs.method) != \(rhs.method) "
        }
        if !(lhs.params ==? rhs.params) {
            string = string + "\(lhs.params?.description ?? "(nil)") != \(rhs.params?.description ?? "(nil)")"
        }

        return string
    }
}

/**
 RPC parameters can either be an array of Codable conformable variables
 */
public enum RpcParams { //: Equatable {
    case byPosition(ParamsByPosition)
    case byName(ParamsByName)
//    case empty
}

extension RpcParams: Codable {
    
    public enum RpcParamsError: Error {
        case decoding(String)
    }
    
    enum CodingKeys: String, CodingKey {
        case params
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
//        if container.decodeNil() {
//            self = .empty
//        }
        do {
            let array = try container.decode(ParamsByPosition.self)
            self = .byPosition(array)
        } catch {
            let dict = try container.decode(ParamsByName.self)
            self = .byName(dict)
        }
        
        /*
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let optionalArray = try? container.decodeIfPresent(ParamsByPosition.self, forKey: .params), let array = optionalArray {
            self = .byPosition(array)
        } else if let dict = try container.decodeIfPresent(ParamsByName.self, forKey: .params) {
            self = .byName(dict)
        } else {
            throw RpcParamsError.decoding("Could not decode \(decoder)")
        }*/
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .byPosition(let array):
            try container.encode(array)
        case .byName(let dict):
            try container.encode(dict)
        }
        /*
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .byPosition(let array):
            try container.encode(array, forKey: .params)
        case .byName(let dict):
            try container.encode(dict, forKey: .params)
        case .empty:
            break
        } */
    }
}

extension RpcParams: CustomStringConvertible {
    public var description: String {
        switch self {
        case .byPosition(let array):
            return "[\(array)]"
        case .byName(let dict):
            return "{\(dict)}"
//        case .empty:
//            return "[]"
        }
    }
}

extension RpcParams: Equatable {
    public static func == (lhs: RpcParams, rhs: RpcParams) -> Bool {
        switch (lhs, rhs) {
        case let (.byPosition(l), .byPosition(r)):
            return l == r
        case let (.byName(l), .byName(r)):
            return l == r
            
        case (.byPosition, _), (.byName, _):
            return false
        }
    }
}

