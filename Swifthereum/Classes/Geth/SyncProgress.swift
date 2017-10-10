//
//  SyncProgress.swift
//  GethTest
//
//  Created by Ronald Mannak on 10/1/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

// TODO:
public enum sProgress {
    case unknown
    case inProgress (SyncProgress)
    case finishedSync
}

/**
 SyncProgress gives progress indications when the node is synchronising with the Ethereum network.
 */

public struct SyncProgress {
    
    public let currentBlock: Int64
    public let highestBlock: Int64
    public let knownStates: Int64
    public let pulledStates: Int64
    public let startingBlock: Int64
    // Completion percentage from 0.0 to 1.0
    public let percentage: Double // TODO: NSProgress + delegate?

    public init?(progress: GethSyncProgress?) {
        guard let progress = progress else { return nil }
        currentBlock    = progress.getCurrentBlock()
        highestBlock    = progress.getHighestBlock()
        knownStates     = progress.getKnownStates()
        pulledStates    = progress.getPulledStates()
        startingBlock   = progress.getStartingBlock()
        percentage      = Double(currentBlock - startingBlock) / Double(highestBlock - startingBlock)
    }
}
