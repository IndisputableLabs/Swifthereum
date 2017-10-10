//
//  NodeInfo.swift
//  GethTest
//
//  Created by Ronald Mannak on 7/22/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

open class NodeInfo {
    
    internal let _gethNodeInfo: GethNodeInfo
    
    public init(nodeInfo: GethNodeInfo) {
        _gethNodeInfo = nodeInfo
    }
    
}

/*
@interface GethNodeInfo : NSObject <goSeqRefInterface> {
}
@property(strong, readonly) id _ref;

- (id)initWithRef:(id)ref;
- (long)getDiscoveryPort;
- (NSString*)getEnode;
- (NSString*)getID;
- (NSString*)getIP;
- (NSString*)getListenerAddress;
- (long)getListenerPort;
- (NSString*)getName;
- (GethStrings*)getProtocols;
@end */
