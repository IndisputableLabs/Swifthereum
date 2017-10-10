//
//  URLRequest.swift
//  Crisp
//
//  Created by Ronald Mannak on 1/12/17.
//  Copyright © 2017 A Puzzle A Day. All rights reserved.
//

import Foundation


extension URLRequest {
    
    init<A>(resource: Resource<A>) {
        
        /*
         Merge server and resource parameters.
         Add parameters to either body or URL, depending on encoding requested by resource
         */
        
        var endPoint = resource.server.domain
        let parameters: JSONDictionary = {
            // Merges the server's default parameters with the method parameter and the resource specific parameters
            let methodParameter: JSONDictionary = ["method" : resource.rpcMethod]
            var serverParameters: JSONDictionary = resource.server.defaultParameters
            serverParameters = serverParameters.merge(with: methodParameter)
            return serverParameters.merge(with: resource.parameters)
        }()
        var body: Data? = nil
        switch resource.encoding {
        case .json:
            body = parameters.jsonEncodedData
        case .url:
            if let parameters = parameters.urlEncodedString {
                endPoint += "?\(parameters)"
            }
        case .body:
            body = parameters.bodyEncodedData
        }
        
        self.init(url: URL(string: endPoint)!)
        
        // Set body
        httpBody = body
        
        // Set headers
        addValue(resource.encoding.contentType(), forHTTPHeaderField: "Content-Type")
        addValue(resource.encoding.contentType(), forHTTPHeaderField: "Accept")
        
        print(allHTTPHeaderFields ?? "")
        print (self)
    }
}
