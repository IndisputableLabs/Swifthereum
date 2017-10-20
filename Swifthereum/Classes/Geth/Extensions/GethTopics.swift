//
//  GethTopics.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/26/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

/**
 Topics is a set of topic lists to filter events with.
 */
extension GethTopics {
    
    open func array() throws -> [Topic]  {
        // Since Swift doesn't allow generics in protocols, we'll copy the same parser for every of Geth's array classes
        var topics = [[Hash]]()
        for i in 0 ..< size() {
            let gethTopic = try get(i)
            var topic = [Hash]()
            for j in 0 ..< gethTopic.size() {
                let gethHash = try gethTopic.get(j)
                topic.append(Hash(hash: gethHash))
            }
            topics.append(topic)
        }
        return topics
    }
    
    public convenience init(topics: [Topic]) throws {
        self.init()
        for i in 0 ..< topics.count {
            guard let gethHashes = GethNewHashes(topics[i].count) else { continue }
            for j in 0 ..< topics[i].count {
                try gethHashes.set(j, hash: topics[i][j]._gethHash)
            }
            assert(gethHashes.size() == topics[i].count) // TODO: move to unit tests
            try set(i, topics: gethHashes)
        }
        assert(size() == topics.count) // TODO: move to unit tests
    }
}
