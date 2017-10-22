//
//  PublicKey.swift
//  BigInt
//
//  Created by Ronald Mannak on 10/21/17.
//

import Foundation
import BigInt

public struct PublicKey: HashProtocol {
    
    public let hash: HashString
    
    public static var hashLength: Int? = 40 // 20 bytes
    
    public init?(hex: HashString) {
        guard let hash = String(hex: hex, length: type(of: self).hashLength) else { return nil }
        self.hash = hash
    }
}
