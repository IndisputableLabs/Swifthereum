//
//  TransactOptions.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/22/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

/**
 Transaction authentication options
 */
open class TransactOptions {
    internal let _gethTransactOptions: GethTransactOpts
    
    public init(transactOptions: GethTransactOpts) {
        _gethTransactOptions = transactOptions
    }
}

/*
 @interface GethTransactOpts : NSObject <goSeqRefInterface> {
 }
 @property(strong, readonly) id _ref;
 
 - (id)initWithRef:(id)ref;
 - (GethAddress*)getFrom;
 - (int64_t)getGasLimit;
 - (GethBigInt*)getGasPrice;
 - (int64_t)getNonce;
 - (GethBigInt*)getValue;
 - (void)setContext:(GethContext*)context;
 - (void)setFrom:(GethAddress*)from;
 - (void)setGasLimit:(int64_t)limit;
 - (void)setGasPrice:(GethBigInt*)price;
 - (void)setNonce:(int64_t)nonce;
 - (void)setSigner:(id<GethSigner>)s;
 - (void)setValue:(GethBigInt*)value;
 @end*/
