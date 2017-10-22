//
//  HashProtocol.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/18/17.
//

import Foundation

public typealias HashString = String

/**
 Hash protocol
 */
public protocol HashProtocol: Codable, Equatable, CustomStringConvertible {
    
    /// Stores the hash without the 0x prefix
    var hash: HashString { get }
    
    /// Hash length without the 0x prefix
    static var hashLength: Int? { get }
    
    init?(hex: String)
}

extension HashProtocol {
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hash == rhs.hash
    }
    
    public var description: String {
        return "0x" + hash
    }
}
