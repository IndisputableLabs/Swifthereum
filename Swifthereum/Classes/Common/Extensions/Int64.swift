//
//  Int64.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/19/17.
//

import Foundation

extension Int64 {
    public var hexValue: String {
        return "0x" + String(format:"%02x", self)
    }
    
    public init?(hex: String) {
        var hex = hex
        hex = hex.remove0xPrefix()
        guard let int = Int64(hex, radix: 16) else { return nil }
        self = int
    }
}

extension Int {
    public var hexValue: String {
        return "0x" + String(format:"%02x", self)
    }
    
    public init?(hex: String) {
        var hex = hex
        hex = hex.remove0xPrefix()
        guard let int = Int(hex, radix: 16) else { return nil }
        self = int
    }
}
