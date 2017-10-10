//
//  Account.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/21/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

/**
 Wraps the GethAccount object in a Swift friendly object.
 
 Account objects do not hold the sensitive private keys of the associated Ethereum accounts, but are merely placeholders to identify the cryptographic keys with. All operations that require authorization (e.g. transaction signing) are performed by the account manager after granting it access to the private keys.
 
 There are a few different ways one can authorize the account manager to execute signing operations, each having its advantages and drawbacks. Since the different methods have wildly different security guarantees, it is essential to be clear on how each works:
 
     - Single authorization: The simplest way to sign a transaction via the keystore is to provide the passphrase of the account every time something needs to be signed, which will ephemerally decrypt the private key, execute the signing operation and immediately throw away the decrypted key. The drawbacks are that the passphrase needs to be queried from the user every time, which can become annoying if done frequently; or the application needs to keep the passphrase in memory, which can have security consequences if not done properly; and depending on the keystore's configured strength, constantly decrypting keys can result in non-negligible resource requirements.
     - Multiple authorizations: A more complex way of signing transactions via the keystore is to unlock the account via its passphrase once, and allow the account manager to cache the decrypted private key, enabling all subsequent signing requests to complete without the passphrase. The lifetime of the cached private key may be managed manually (by explicitly locking the account back up) or automatically (by providing a timeout during unlock). This mechanism is useful for scenarios where the user may need to sign many transactions or the application would need to do so without requiring user input. The crucial aspect to remember is that anyone with access to the account manager can sign transactions while a particular account is unlocked (e.g. device left unattended; application running untrusted code).
 
 [Ethereum Account reference](https://godoc.org/github.com/ethereum/go-ethereum/accounts#Account)
 
 - Remark:
 The referenced GethAccount instance is marked internal. GethAccount throws uncaught exceptions when instance methods are called incorrectly
 */
open class Account {
    
    internal var _gethAccount: GethAccount
    open var path: String { return _gethAccount.getURL() }
    
    /// Optional resource locator within a backend
    open var url: URL? { return URL(string: path) }
    
    /// Ethereum account address derived from the key
    open var address: Address { return Address(address: _gethAccount.getAddress()) }
    
    init(account: GethAccount) {
        _gethAccount = account
    }
}

extension Account: CustomStringConvertible {
    open var description: String {
        return path + " : " + address.description
    }
}

