//
//  GethBigInt.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/22/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth
import BigInt

public extension GethBigInt {
    
    public var bigInt: BigInt {
        return BigInt(string())!
    }
    
    public convenience init(_ bigInt: BigInt) {
        self.init()
        setString(bigInt.description, base: 10)
    }
}
