//
//  Account.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/19/17.
//

import Foundation

// http://www.ethdocs.org/en/latest/account-management.html
public struct Account {
    public let address: Address
    
    /// Path to the Keyfile stored in teh keystore subdirectory of the Ethereum node’s data directory (?)
    public let url: URL
}
