//
//  Node.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/22/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

/// Wrapper for GethNode. Node represents a Geth Ethereum node instance.
open class Node {
    
    open let _gethNode: GethNode
    
    // The following properties are part of GethNodeInfo
    
    open var discoveryPort: Int { return _gethNode.getInfo().getDiscoveryPort() }
    
    open var encode: String { return _gethNode.getInfo().getEnode() }
    
    open var id: String { return _gethNode.getInfo().getID() }
    
    open var ipAddress: String { return _gethNode.getInfo().getIP() }
    
    open var listenerAddress: String { return _gethNode.getInfo().getListenerAddress() }
    
    open var listenerPort: Int { return _gethNode.getInfo().getListenerPort() }
    
    open var name: String { return _gethNode.getInfo().getName() }
    
    open var protocols: [String] { return _gethNode.getInfo().getProtocols().array }
        
    public init(node: GethNode) {
        _gethNode = node
    }
    
    public init(networkID: ChainID = .main, dataDirectory: String? = nil) throws {
        let directory: String
        if let dataDirectory = dataDirectory {
            directory = dataDirectory
        } else {
            directory  = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/" + networkID.subdirectory
        }
        
        let nodeConfig = NodeConfig(networkID: networkID)
        var error: NSError? = nil
        _gethNode = GethNewNode(directory, nodeConfig._gethNodeConfig, &error)
        guard error == nil else {
            throw error!
        }
        print("Saving to directory \(directory)")
    }
    
    /// Retrieves a client to access the Ethereum subsystem.
    open func ethereumClient() throws -> EthereumClient {
        return try EthereumClient(client: _gethNode.getEthereumClient())
    }
    
    /// GetPeersInfo returns an array of metadata objects describing connected peers.
    open func peersInfo() throws -> [PeerInfo] {
        return try _gethNode.getPeersInfo().array()
    }
    
    /**
     Start creates a live P2P node and starts running it.
     - Throws: error
     */
    open func start() throws {
        try _gethNode.start()
    }
    
    /**
     Stop terminates a running node along with all it's services. In the node was not started, an error is returned.
     - Throws: error
     */
    open func stop() throws {
        try _gethNode.stop()
    }
}

/*
@interface GethNode : NSObject <goSeqRefInterface> {
}
@property(strong, readonly) id _ref;

 /// returns an array of metadata objects describing connected peers.
- (GethPeerInfos*)getPeersInfo;
@end
*/

