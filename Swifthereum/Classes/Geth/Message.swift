//
//  Message.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth
import BigInt

/**
 * CallMsg contains parameters for contract calls.
 */
public struct Message {
    
    public let _callMsg: GethCallMsg
    
    public var data: Data {
        get { return _callMsg.getData() }
        set { _callMsg.setData(data) }
    }
    
    public var from: Address {
        get { return Address(address: _callMsg.getFrom()) }
        set { _callMsg.setFrom(from._gethAddress) }
    }
    
    public var to: Address {
        get { return Address(address: _callMsg.getFrom()) }
        set { _callMsg.setFrom(to._gethAddress) }
    }
    
    public var gas: Gas {
        get { return _callMsg.getGas() }
        set { _callMsg.setGas(gas) }
    }
    
    public var gasPrice: BigInt {
        get { return BigInt(_callMsg.getGasPrice()) }
        set { _callMsg.setGasPrice(GethBigInt(gasPrice)) }
    }
    
    public var value: BigInt {
        get { return BigInt(_callMsg.getValue().string())! }
        set { _callMsg.setValue(GethBigInt(value)) }
    }
}

