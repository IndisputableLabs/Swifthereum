//
//  URLRequest.swift
//  Crisp
//
//  Created by Ronald Mannak on 1/12/17.
//  Copyright © 2017 A Puzzle A Day. All rights reserved.
//

import Foundation


extension URLRequest {
    
    public init<A>(resource: Resource<A>) throws {
        
        /*
         Add parameters to either body or URL, depending on encoding requested by resource
         */
        
        var endPoint = resource.server.domain
        var body: Data? = nil
        switch resource.encoding {
        case .json:
            body = resource.parameters.jsonEncodedData
        case .url:
            if let parameters = resource.parameters.urlEncodedString {
                //print("parameters: \(parameters)")
                endPoint += "?\(parameters)"
            }
        case .body:
            body = resource.parameters.bodyEncodedData
        }
        guard let url = URL(string: endPoint) else { throw SwifthereumError.unexpectedNilError }
        self.init(url: url)
    
        httpBody = body
        httpMethod = resource.httpMethod.rawValue
        
        // Set headers
        addValue(resource.encoding.contentType(), forHTTPHeaderField: "Content-Type")
        addValue(resource.encoding.contentType(), forHTTPHeaderField: "Accept")
    }
}
