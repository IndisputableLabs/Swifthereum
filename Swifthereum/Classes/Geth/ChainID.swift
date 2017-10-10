//
//  NetworkID.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/22/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth
import BigInt

public typealias ChainIDValue = BigInt
/**
 Ethereum Chain IDs
 Most common used chain IDs are Main a
*/
public enum ChainID: ChainIDValue  {
    case olympic    = 0         // Ethereum prerelease Testnet (OBSOLETE)
    case main       = 1         // Ethereum Main Net (Frontier, Homestead, Metropolis, Serenity)
    case morden     = 2         // Ethereum Morden Testnet (OBSOLETE)
    case ropsten    = 3         // Ethereum Ropsten Testnet (OBSOLETE)
    case rinkeby    = 4         // Ethereum Rinkeby Testnet
    case kovan      = 42        // Ethereum Kovan open parity testnet
    case musicoin   = 7762959   // The music blockchain
}

extension ChainID {
    
    /** Returns genesis block of the chains. Setting the genesis block in nodeconfig effectively choses which chain to join.
     */
    var genesisBlock: String? {
        switch self {
        case .main:
            return GethMainnetGenesis()
        case .rinkeby:
            return GethRinkebyGenesis()
        default:
            return nil     // nil defaults to main net
            // Unused: GethTestnetGenesis();
        }
    }
    
    /**
     Returns the default subdirectory for the chosen network. Storing the blocks in the document directory directly makes switching between networks impossible. Geth will complain a different genesis block is stored on disk. Storing each network in a different subdirectory fixes that issue
     */
    var subdirectory: String {
        switch self {
        case .olympic:
            return "Olympic"
        case .main:
            return "MainNet"
        case .morden:
            return "Morden"
        case .ropsten:
            return "Ropsten"
        case .rinkeby:
            return "Rinkeby"
        case .kovan:
            return "Kovan"
        case .musicoin:
            return "Musicoin"        
        }
    }
}
