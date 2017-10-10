//
//  NodeConfig.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/22/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

/**
 Wrapper for GethNodeCnfig class
 */
open class NodeConfig {
    
    /// Stores the original GethNodeConfig instance
    open let _gethNodeConfig: GethNodeConfig
    
    /// Bootstrap nodes used to establish connectivity with the rest of the network.
//    open var bootstrapNodes: [Node] {
//        set {
////            _gethNodeConfig.setBootstrapNodes(newValue.map({ GethNewNode(<#T##datadir: String!##String!#>, <#T##config: GethNodeConfig!##GethNodeConfig!#>, <#T##error: NSErrorPointer##NSErrorPointer#>) }))
//            }
//        }
//        get {
//            return _geth
//        }
//    }
    
    /// MaxPeers is the maximum number of peers that can be connected. If this is set to zero, then only the configured static and trusted peers can connect.
    open var maxPeers: Int {
        set { _gethNodeConfig.setMaxPeers(maxPeers) }
        get { return _gethNodeConfig.maxPeers() }
    }
    
    /// EthereumEnabled specifies whether the node should run the Ethereum protocol.
    open var ethereumEnabled: Bool {
        set { _gethNodeConfig.setEthereumEnabled(ethereumEnabled) }
        get { return _gethNodeConfig.ethereumEnabled() }
    }
    
    /// EthereumGenesis is the genesis JSON to use to seed the blockchain with. An empty genesis state is equivalent to using the mainnet's state.
    open var genesis: String? {
        set { _gethNodeConfig.setEthereumGenesis(genesis ?? "")}
        get { return _gethNodeConfig.ethereumGenesis() }
    }
    
    /** EthereumNetworkID is the network identifier used by the Ethereum protocol to decide if remote peers should be accepted or not.
     This is not the ChainID, but usually set to the same id as the chainID.
     */
    open var networkID: Int64 {
        set { _gethNodeConfig.setEthereumNetworkID(networkID) }
        get { return _gethNodeConfig.ethereumNetworkID() }
    }
    
    /// EthereumDatabaseCache is the system memory in MB to allocate for database caching. A minimum of 16MB is always reserved.
    open var databaseCache: Int {
        set { _gethNodeConfig.setEthereumDatabaseCache(databaseCache) }
        get { return _gethNodeConfig.ethereumDatabaseCache() }
    }
    
    /// EthereumNetStats is a netstats connection string to use to report various chain, transaction and node stats to a monitoring server. It has the form "nodename:secret@host:port"
    open var netStats: String {
        set { _gethNodeConfig.setEthereumNetStats(netStats) }
        get { return _gethNodeConfig.ethereumNetStats() }
    }
    
    /// WhisperEnabled specifies whether the node should run the Whisper protocol.
    open var whisperEnabled: Bool {
        set { _gethNodeConfig.setWhisperEnabled(whisperEnabled) }
        get { return _gethNodeConfig.whisperEnabled() }
    }
    
    public init(nodeConfig: GethNodeConfig) {
        _gethNodeConfig = nodeConfig
    }
    
    public init(networkID: ChainID = ChainID.main) {
        _gethNodeConfig = GethNewNodeConfig()
        self.networkID = Int64(networkID.rawValue)
        genesis = networkID.genesisBlock
    }
}


