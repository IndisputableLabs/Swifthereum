//
//  GethPeerInfos.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/30/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

extension GethPeerInfos {
    
    /// Creates a [String] Array from the embedded strings in GethStrings
    open func array() throws -> [PeerInfo] {
        // Since Swift doesn't allow generics in protocols, we'll copy the same parser for every of Geth's array classes
        var array: [PeerInfo] = []
        for i in 0 ..< size() {
            let item = try get(i)
            array.append(PeerInfo(peerInfo: item))
        }
        return array
    }
}
