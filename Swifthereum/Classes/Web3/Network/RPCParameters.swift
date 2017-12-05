//
//  RPCParams.swift
//  BigInt
//
//  Created by Ronald Mannak on 11/29/17.
//

import Foundation

// TODO: Change back to Codable
public typealias ParamsByPosition = [String] //[Codable]
public typealias ParamsByName = JSONDictionary //[RPCParameter]

/**
 RPC parameters can either be an array of Codable conformable variables
 */
public enum RPCParameters { //: Equatable {
    case byPosition(ParamsByPosition)
    case byName(JSONDictionary)
}

extension RPCParameters {
    public init(byPosition: ParamsByPosition?) {
        guard let byPosition = byPosition else {
            self = .byPosition([])
            return
        }
        self = .byPosition(byPosition)
    }
    
    public init(byName: JSONDictionary?) {
        guard let byName = byName else {
            self = .byPosition([])
            return
        }
        
        self = .byName(byName)
        /*
        var parameterArray = [RPCParameter]()
        for key in byName.keys {
            let value = byName.val
            parameterArray.append(RPCParameter<value.type>(key: key, value: value))
        }
        self = .byName(parameterArray) */
    }
    
    public func parametersValue() -> Codable {
        switch self {
        case .byPosition(let array): return array
        case .byName(let dict): return dict
        }
    }
}

extension RPCParameters: Codable {
    
    public enum RpcParamsError: Error {
        case decoding(String)
    }
    
    private enum CodingKeys: String, CodingKey {
        case params
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do {
            let array = try container.decode(ParamsByPosition.self)
            self = .byPosition(array)
        } catch {
            let dict = try container.decode(JSONDictionary.self)
            self = .byName(dict)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .byPosition(let array):
            try container.encode(array)
        case .byName(let dict):
            try container.encode(dict)
        }
    }
}

extension RPCParameters: CustomStringConvertible {
    public var description: String {
        switch self {
        case .byPosition(let array):
            return "[\(array)]"
        case .byName(let dict):
            return "{\(dict)}"
        }
    }
}

extension RPCParameters: Equatable {
    public static func == (lhs: RPCParameters, rhs: RPCParameters) -> Bool {
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

