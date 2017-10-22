//
//  Work.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/21/17.
//

import Foundation

/**
DATA, 8 Bytes - The nonce found (64 bits)
DATA, 32 Bytes - The header's pow-hash (256 bits)
DATA, 32 Bytes - The mix digest (256 bits)
*/

public struct Work: Codable {
    let nonce:      String
    let powHash:    String
    let mixDigest:  String
}
