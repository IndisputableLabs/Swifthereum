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
         Merge server and resource parameters.
         Add parameters to either body or URL, depending on encoding requested by resource
         */
        
        var endPoint = resource.server.domain
        let parameters: JSONDictionary = {
            let messageParameters: JSONDictionary? = resource.parameters
            var serverParameters: JSONDictionary = resource.server.defaultParameters
            serverParameters = serverParameters.merge(with: messageParameters)
            return serverParameters
        }()
        var body: Data? = nil
        switch resource.encoding {
        case .json:
            body = parameters.jsonEncodedData
        case .url:
            if let parameters = parameters.urlEncodedString {
                //print("parameters: \(parameters)")
                endPoint += "?\(parameters)"
            }
        case .body:
            body = parameters.bodyEncodedData
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
