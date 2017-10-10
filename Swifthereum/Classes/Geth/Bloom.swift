//
//  Bloom.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/28/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

/**
 * Bloom represents a 256 bit bloom filter.
 */
open class Bloom {
    
    open let _gethBloom: GethBloom
    
    /**
     * GetBytes retrieves the byte representation of the bloom filter.
     */
    open var bytes: Data { return _gethBloom.getBytes() }
    
    /**
     * GetHex retrieves the hex string representation of the bloom filter.
     */
    open var hex: String { return _gethBloom.getHex() }
    
    public init(gethBloom: GethBloom) {
        _gethBloom = gethBloom
    }
}
