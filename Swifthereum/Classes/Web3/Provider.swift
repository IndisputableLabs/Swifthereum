//
//  Provider.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation

/**
 */
public enum Provider {
    
    ///
    case web3(server: Server)
    
//    case infura(network: NetworkID, )
    /* do we need a separate Infura option that automatically connects to the right network?
     Mainnet    production network    https://mainnet.infura.io
     Ropsten    test network    https://ropsten.infura.io
     INFURAnet    test network    https://infuranet.infura.io
     Kovan    test network    https://kovan.infura.io
     Rinkeby    test network    https://rinkeby.infura.io
     IPFS    gateway    https://ipfs.infura.io
 
 */
    
    ///
    case ipc(fileURL: URL)
}

