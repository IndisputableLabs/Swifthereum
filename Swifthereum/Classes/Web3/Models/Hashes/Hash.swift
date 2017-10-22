//
//  Hash.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/21/17.
//

import Foundation
import BigInt

/** Generic hash of any length
 */
public struct Hash: HashProtocol {
    
    public let hash: HashString
    
    public static var hashLength: Int? = nil
    
    public init?(hex: HashString) {
        guard let hash = String(hex: hex) else { return nil }
        self.hash = hash
    }
}
