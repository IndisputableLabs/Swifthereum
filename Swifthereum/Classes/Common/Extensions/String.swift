//
//  String.swift
//  GethTest
//
//  Created by Ronald Mannak on 10/7/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation

extension String {

    /// Returns true if self is a valid hex string. Will ignore 0x prefix if present.
    public func isValidHex() -> Bool {
        var string = self
        if has0xPrefix() == true {
            string = String(string.dropFirst(2))
        }
        let chars = CharacterSet(charactersIn: "0123456789ABCDEF").inverted
        guard string.uppercased().rangeOfCharacter(from: chars) == nil else {
            return false
        }
        return true
    }
    
    /// Returns true if self has 0x prefix
    public func has0xPrefix() -> Bool {
        return hasPrefix("0x") || hasPrefix("0X")
    }
    
    
    /**
     Show hexadecimal representation of self
     - example: `"0ffbF245095dB".hexString` will return ""
     */
    public var hexString: String {
        return unicodeScalars.filter { $0.isASCII }.map { String(format: "%02X : ", $0.value) }.joined()
    }
    
}
    
extension String {
    /**
     Trims ending characters, used to print remainder of balances. For example a remainder of "54000" will be truncated to "54"
     
     Swiftiness could be improved.
     */
    func trim(_ character: String = "0") -> String {
        if suffix(1) == "0" {
            return String(prefix(count - 1)).trim(character)
        }
        return self
    }
    
    /**
     For example, when passed an amount of 240000, insert will return "240,000"
     */
    func insert(seperator: String, afterEvery: Int) -> String {
        var output = ""
        characters.reversed().enumerated().forEach { index, c in
            if index % afterEvery == 0 && index > 0 {
                output += seperator
            }
            output.append(c)
        }
        return String(output.reversed())
    }
}

