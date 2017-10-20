//
//  Int64.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/19/17.
//

import Foundation

extension Int64 {
    var hexValue: String {
        return "0x" + String(format:"%02X", self)
    }
}
