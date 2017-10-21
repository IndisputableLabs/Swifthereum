//
//  Version.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation

/**
 Generic Web3 result.
 A successful result could be: {"jsonrpc":"2.0","id":61,"result":"1"}
 An error looks like this: {"jsonrpc":"2.0","id":1,"error":{"code":-32602,"message":"eth_GetTransactionByHash expects 1 parameters, got 0"}}
 No HTTP error codes are sent by Ethereum.
 */
public struct Web3Result<A: Decodable>: Decodable {

    public let jsonrpc: String
    public let id: Int
    public let result: A?
    public let error: Web3Error?
    
    // For debugging purposes
//    public init(from decoder: Decoder) throws {
//        let jsonrpc = try values.decode(String.self, for: jsonrpc)
//    }
}

/**
 {"jsonrpc":"2.0","id":61,"error":{"code":-32602,"message":"missing value for required argument 0"}}
 */
public struct Web3Error: Decodable {
    public let code: Int
    public let message: String
}
