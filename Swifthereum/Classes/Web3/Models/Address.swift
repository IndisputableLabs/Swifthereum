//
//  Address.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/18/17.
//

import Foundation

public typealias Address = String

extension Address {
    
    public static var addressLength = 40
    
    ///
    public init?(hex: String) {
        var hex = hex
        // Remove ethereum: prefix if present
        if hex.hasPrefix("ethereum:"), let index = hex.range(of: "ethereum:")?.upperBound {
            hex = String(hex[index...])
        }
        if hex.has0xPrefix() == false {
            hex = "0x" + hex
        }
        self.init(hex)
        // Check if
        if isValid() == false { return nil }
    }
    
    ///
    public func isValid() -> Bool {
        // A valid address is 40 characters long without the 0x prefix
        if hasPrefix("0x") {
            if count != Address.addressLength + 2 { return false }
        } else {
            if count != Address.addressLength { return false }
        }
        // String has the right length. Is it hex?
        return isValidHex()
    }
}
