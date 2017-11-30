//
//  Codable.swift
//  BigInt
//
//  Created by Ronald Mannak on 11/29/17.
//

import Foundation

// Source: https://stackoverflow.com/questions/45209743/how-can-i-use-swift-s-codable-to-encode-into-a-dictionary

extension Encodable {
    
    func asDictionary() throws -> JSONDictionary {
        let data = try JSONEncoder().encode(self)
        
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONDictionary else {
            throw SwifthereumError.encodingError("Cannot parse: \(String(describing: String(data: data, encoding: .utf8)))")
        }
        return dictionary
    }
}
