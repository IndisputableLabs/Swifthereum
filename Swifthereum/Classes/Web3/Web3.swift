//
//  Web3.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation



/*
 enum version = "web3_clientVersion"
 
 var result: Class {
 switch self:
 case
 
 */


public protocol ProviderProtocol {
    var provider: Provider { get set }
}

open class Web3: ProviderProtocol {
    
    open let version = "1.0.0"
    open var modules: [ProviderProtocol]?
    
    open var provider: Provider {
        didSet {
            guard let modules = modules else { return }
            for module in modules {
                //module.provider = provider
            }
        }
    }
    
//    let eth = Eth()
//    let *.net
//    let bzz
//    let ssh
//    let utils
    
    init(provider: Provider) {
        self.provider = provider
//        eth.provider = provider
//        bzz.provider = provider
//        ...
    }
    
    ////"method":   "web3_clientVersion",
}

