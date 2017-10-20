//
//  BigInt+Geth.swift
//  Swifthereum_Example
//
//  Created by Ronald Mannak on 10/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Geth
import BigInt

extension BigInt {
    
    /**
     init for initializing BigInts with a GethBigInt
     */
    public init(_ gethBigInt: GethBigInt) {
        self.init(gethBigInt.string())!
    }

}
