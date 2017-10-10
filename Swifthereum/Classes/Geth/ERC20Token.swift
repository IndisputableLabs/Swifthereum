//
//  ERC20Token.swift
//  GethTest
//
//  Created by Ronald Mannak on 10/8/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

/**
 
 */
public struct ERC20Token: Codable {
    
    // TODO: Quick and dirty way to store cacheURL and tokenListPath and allow developers to override the default values.
    public static var cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("ethTokens.json")
    /// Often updated list of all ERC-20 tokens in JSON format.
    public static var tokenListPath = "https://raw.githubusercontent.com/kvhnuke/etherwallet/mercury/app/scripts/tokens/ethTokens.json"
    
    public let address: Address
    public let symbol: String
    public let decimal: Int
    public let type: String
    
    // TODO: implement ERC20 methods
    
    
    public static func clearTokenCache() throws {
        try FileManager.default.removeItem(at: cacheURL)
    }
    
    public static func tokenCacheExists() -> Bool {
        return FileManager.default.fileExists(atPath: cacheURL.path)
    }
    
    /**
     Loads all known ERC20 tokens.
     */
    public static func fetchTokens(symbol: NSPredicate? = nil, useCacheAsBackup: Bool = true, completion: @escaping ([ERC20Token]?, Error?) -> ()) {
        
        downloadTokenList { data, error in
            
            // If download returned an error, try cache
            guard let data = data, error == nil  else {
                print(error ?? "nil error")
                
                // Return cached tokens
                let fileManager = FileManager.default
                guard tokenCacheExists() == true, useCacheAsBackup == true, fileManager.fileExists(atPath: cacheURL.path) == true, let data = fileManager.contents(atPath: cacheURL.path) else {
                    completion(nil, SwifthereumError.fileError)
                    return
                }
                parseJSON(data: data, completion: completion)
                return
            }
            parseJSON(data: data, completion: completion)
        }
    }
    
    fileprivate static func parseJSON(data: Data, completion: @escaping ([ERC20Token]?, Error?) -> ()) {
        let decoder = JSONDecoder()
        do {
            let tokens = try decoder.decode([ERC20Token].self, from: data)
            completion(tokens, nil)
        } catch {
            print(error)
            completion(nil, error)
        }
    }
    
    fileprivate static func downloadTokenList(completion: @escaping (Data?, Error?) -> ()) {
        let url = URL(string: tokenListPath)!
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        session.dataTask(with: urlRequest) { data, response, error in
            print(response ?? "no response")
            if let data = data {
                print(String(data: data, encoding: .utf8) ?? "no data")
            }
            
            // Save data in cache
            if let data = data, error == nil {
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: cacheURL.path) {
                    try? clearTokenCache()
                }
                fileManager.createFile(atPath: cacheURL.path, contents: data, attributes: nil)
            }
            completion(data, error)
        }.resume()
    }
}
