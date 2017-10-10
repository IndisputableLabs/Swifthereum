//
//  PeerInfo.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/30/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

/**
 * PeerInfo represents pi short summary of the information known about pi connected peer.
 */
public struct PeerInfo {
    
    public let caps: [String]
    public let id: String
    public let localAddress: String
    public let name: String
    public let remoteAddress: String
    
    public init(peerInfo: GethPeerInfo) {
        caps = peerInfo.getCaps().array
        id = peerInfo.getID()
        localAddress = peerInfo.getLocalAddress()
        name = peerInfo.getName()
        remoteAddress = peerInfo.getRemoteAddress()
    }
}
