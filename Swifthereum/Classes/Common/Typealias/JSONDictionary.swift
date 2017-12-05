//
//  JSONDictionary.swift
//  Crisp
//
//  Created by Ronald Mannak on 1/12/17.
//  Copyright © 2017 A Puzzle A Day. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String: Codable]

extension Dictionary where Key == String, Value == Codable {

    /**
     Returns a URL ecoded String for use in URL parameters. E.g.: "appId=1234&query=56789".
     Use for GET, HEAD and DELETE methods.
     */
    var urlEncodedString: String? {
        
        var encodedArray = [String]()
        for (key, value) in self {
            guard let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                assertionFailure("Parsing error")
                return nil
            }
            guard let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                assertionFailure("Parsing error")
                return nil
            }
            encodedArray.append("\(encodedKey)=\(encodedValue)")
        }
        return encodedArray.joined(separator: "&")
    }
    
    /**
     Encodes parameters in Data for use as HTTPBody.
     Use for POST, PUT, PATCH methods.
     */
    var bodyEncodedData: Data? {
        
        let array = self.map{ key, value in
            return "\(key)=\(value)"
        }
        let string = array.joined(separator: "&")
        return string.data(using: .utf8, allowLossyConversion: false)
    }
    
    var jsonEncodedData: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
    
    /**
     Merges two dictionaries. Keys of second dictionary overwrite keys of self
     */
    mutating func merge(with dictionary:[Key: Value]?) -> [Key: Value] {
        guard let dictionary = dictionary else {
            return self
        }
        
        _ = dictionary.flatMap { key, value in
            self.updateValue(value, forKey: key)
        }
        return self
    }
}

public func ==<K, V>(lhs: [K: V], rhs: [K: V] ) -> Bool {
    return (lhs as NSDictionary).isEqual(to: rhs)
}
