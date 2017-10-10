//
//  FilterQuery.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth
import BigInt

/**
 * FilterQuery contains options for contact log filtering.
 */
open class FilterQuery {
    
    /// Embedded GethFilterQuery
    open let _gethFilterQuery: GethFilterQuery
    
    var addresses: [Address]? {
        get {
            guard let array = try? _gethFilterQuery.getAddresses().array(), !array.isEmpty else { return nil }
            return array
        }
        set {
            let array = addresses ?? [Address]()
            _gethFilterQuery.setAddresses(try? GethAddresses(items: array))
        }
    }
    
    var fromBlock: BigInt {
        get { return BigInt(_gethFilterQuery.getFromBlock()) }
        set { _gethFilterQuery.setFromBlock(GethBigInt(fromBlock)) }
    }
    
    var toBlock: BigInt {
        get { return BigInt(_gethFilterQuery.getToBlock()) }
        set { _gethFilterQuery.setToBlock(GethBigInt(toBlock)) }
    }
    
    var topics: [Topic]? {
        get {
            guard let array = try? _gethFilterQuery.getTopics().array(), !array.isEmpty else { return nil }
            return array
        }
        set {
            let array = topics ?? [Topic]()
            let gethTopics = try? GethTopics(topics: array)
            _gethFilterQuery.setTopics(gethTopics) }
    }
    
    init(addresses: [Address], from: Block, to: Block, topics: [Topic]) {
        _gethFilterQuery = GethNewFilterQuery()
    }
}

