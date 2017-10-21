//
//  Transaction.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/20/17.
//

import Foundation

/**
 
 {"jsonrpc":"2.0","id":1,"result":{
 "blockHash":"0xb92a5a5ba9bf26fc5bc85ae0b18717dbeaf7fdf0c29a4221b277bff8cda49c44",
 "blockNumber":"0x41700a",
 "from":"0x2a65aca4d5fc5b5c859090a6c34d164135398226",
 "gas":"0x15f90",
 "gasPrice":"0x4a817c800",
 "hash":"0x7f853aea006cf7eb1f06b6aefcb1049a48a49bd93a0ae70e7e85b7b284d7662b",
 "input":"0x","nonce":"0x28775d",
 "to":"0x3914bff975ef35e8d3403e1ea953bf886b0e8fea",
 "transactionIndex":"0xa7",
 "value":"0xfd4aa6f26c3400",
 "v":"0x25",
 "r":"0x66315a0ee1382c161b437d8cabe664b14766d945d1cbc57ced573935f286df5",
 "s":"0x72324787b3b2783f44218b57a32e9d2fa5d8e0abf6eb830cf792e1b02c26d8cf"}}
 
 TODO: https://bugs.swift.org/browse/SR-5249
 */
public struct Transaction: Decodable {    
    public let hash: String // TransactionHash
    public let nonce: String //Int64
    public let blockHash: String
    public let transactionIndex: String //Int
    public let from: Address
    public let to: Address
    public let value: String //Wei
    public let gasPrice: String //Wei
    public let gas: String //Int64
    public let input: String
}

// it's bascilly a json in the result: key value embedded/childnode
