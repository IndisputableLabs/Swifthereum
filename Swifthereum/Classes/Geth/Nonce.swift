//
//  Nonce.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/28/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

/**
 * A Nonce is a 64-bit hash which proves (combined with the mix-hash) that
 a sufficient amount of computation has been carried out on a block.
 */
open class Nonce {
    
    open let _gethNonce: GethNonce
    
    /**
     * GetBytes retrieves the byte representation of the block nonce.
     */
    open var bytes: Data { return _gethNonce.getBytes() }
    
    /**
     * GetHex retrieves the hex string representation of the block nonce.
     */
    open var hex: String { return _gethNonce.getHex() }
    
    public init(gethNonce: GethNonce) {
        _gethNonce = gethNonce
    }
}

