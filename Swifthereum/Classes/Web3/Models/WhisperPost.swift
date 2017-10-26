//
//  WhisperPost.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/25/17.
//

import Foundation

public struct WhisperPost {
    public let from: WhisperAddress
    public let to: WhisperAddress
    public let topics: [Hash]
    public let payload: Hash
    public let priority: Int
    public let ttl: TimeInterval
    
    public init(from: WhisperAddress, to: WhisperAddress, topics: [Hash], payload: Hash, priority: Int, ttl: TimeInterval) {
        self.from = from
        self.to = to
        self.topics = topics
        self.payload = payload
        self.priority = priority
        self.ttl = ttl
    }
}

extension WhisperPost: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case from
        case to
        case topics
        case payload
        case priority
        case ttl
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(String(describing: from), forKey: .from)
        try container.encode(String(describing: to), forKey: .to)
        let topics = self.topics.map { String(describing: $0) }
        try container.encode(String(describing: topics), forKey: .topics)
        try container.encode(String(describing: String(describing: payload)), forKey: .payload)
        try container.encode(priority.hexValue, forKey: .payload)
        try container.encode(ttl.ethereumTime.seconds.hexValue, forKey: .ttl)
    }
}
