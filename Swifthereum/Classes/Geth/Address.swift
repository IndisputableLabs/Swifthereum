//
//  Address.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/22/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

/**
 Wraps the GethAddress object in a Swift friendly object

 - Remark:
 The referenced GethAddress instance is marked internal. GethAddress throws uncaught exceptions when instance methods are called incorrectly.
 
 20 bytes: https://ethereum.stackexchange.com/questions/3542/how-are-ethereum-addresses-generated
 */
public struct Address {

    internal let _gethAddress: GethAddress
    
    public var bytes: Data {
        return _gethAddress.getBytes()
    }
    
    public var hex: String {
        return _gethAddress.getHex()
    }
    
    /**
     
     */
    public init(address: GethAddress) {
        _gethAddress = address
    }
    
    /**
     - throws: A Geth error
     */
    public init(bytes: Data) throws {
        _gethAddress = GethAddress()
        try _gethAddress.setBytes(bytes)
    }
    
    public init(qrCode: String) throws {
        // QR codes can have ethereum: prefix but some, like MyEtherWallet, don't.
        let hex: String
        if qrCode.hasPrefix("ethereum:"), let index = qrCode.range(of: "ethereum:")?.upperBound {
            hex = String(qrCode[index...])
        } else {
            hex = qrCode
        }
        try self.init(hex: hex)
    }
    
    
    /**
     - parameter hex: hexadecimal representation of the address in String format
     - throws: A Geth error
     */
    public init(hex: String) throws {
        var error: NSError? = nil
        _gethAddress = GethNewAddressFromHex(hex, &error)
        guard error == nil else { throw(error!) }
    }
}

extension Address: CustomStringConvertible {
    public var description: String {
        return hex
    }
}

extension Address: Codable {
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        let addressHex: String = try value.decode(String.self)
        var error: NSError? = nil
        _gethAddress = GethNewAddressFromHex(addressHex, &error)
        if let error = error { throw error }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(_gethAddress.getHex())
    }
}
