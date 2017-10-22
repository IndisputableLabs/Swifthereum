//
//  NetworkService.swift
//  Crisp
//
//  Created by Ronald Mannak on 1/11/17.
//  Copyright © 2017 A Puzzle A Day. All rights reserved.
//

import Foundation

public enum Result<A> {
    case data(A)
    case error(Error)
    case noData
}

open class NetworkService: NSObject, URLSessionDelegate {
    
    enum NetworkError: Error {
        case urlError(path: String)
        case parameterError(parameters: String)
    }
    
//    fileprivate static let syncQueue = DispatchQueue(label: "NetworkService.syncQueue")
    
    open func load<A>(resource: Resource<A>, debug: Bool = false, completion: @escaping (Result<A>) -> ()) {
        
//        NetworkService.syncQueue.sync {        
        guard let request = URLRequest(resource: resource) else {
            completion(Result.error(SwifthereumError.invalidResource))
            return            
        }
        let session = URLSession(configuration: URLSessionConfiguration.default) //, delegate: nil, delegateQueue: nil)
        session.dataTask(with: request) {data, response, error in
            if debug == true { self.debugPrint(data: data, response: response, error: error) }

            guard error == nil else {
                completion(.error(error!))
                return
            }
            guard let data = data else {
                completion(.noData)
                return
            }
            do {
                if let result = try resource.parse(data) {
                    completion(.data(result))
                    return
                } else {
                    completion(.noData)
                    return
                }
                
            } catch {
                completion(.error(error))
                return
            }
        }.resume()
//    }
    }
    
    private func debugPrint(data: Data?, response: URLResponse?, error: Error?) {
        print("=========================DATA===============================")
        if let data = data, let body = String(data: data, encoding: .utf8) {
        print (body)
        }
        print("=========================RESPONSE===========================")
        print(response ?? "")
        print("=========================ERR================================")
        print(error ?? "")
    }
}
