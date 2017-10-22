//
//  Wei.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import BigInt

public typealias Wei = BigInt

public enum EthereumUnit {
    
    case wei, kwei, ada, femtoether, gwei, shannon, nanoether, nano, szabo, microether, micro, finney, millether, milli, ether, kether, grand, einstein, mether, gether, tether
    
    public var coefficient: Double {
        switch self {
        case .wei: return 1
        case .kwei, .ada, .femtoether: return 0.001
        case .gwei, .shannon, .nanoether, .nano:  return 0.000_000_001
        case .szabo, .microether, .micro: return 0.000_000_000_001
        case .finney, .millether, .milli: return 0.000_000_000_000_001
        case .ether: return 0.000_000_000_000_000_001
        case .kether, .grand, .einstein: return 0.000_000_000_000_000_000_001
        case .mether: return 0.000_000_000_000_000_000_000_001
        case .gether: return 0.000_000_000_000_000_000_000_000_001
        case .tether: return 0.000_000_000_000_000_000_000_000_000_001
        }
    }
    
    public var factor: BigInt {
        switch self {
        case .wei: return BigInt(1)
        case .kwei, .ada, .femtoether: return BigInt("1000")
        case .gwei, .shannon, .nanoether, .nano:  return BigInt("1000000000") // How to ignore those _ ??
        case .szabo, .microether, .micro: return BigInt("1000000000000")
        case .finney, .millether, .milli: return BigInt("1000000000000000")
        case .ether: return BigInt("1000000000000000000")
        case .kether, .grand, .einstein: return BigInt("1000000000000000000000")
        case .mether: return BigInt("1000000000000000000000000")
        case .gether: return BigInt("1000000000000000000000000000")
        case .tether: return BigInt("1000000000000000000000000000000")
        }
    }
  
    fileprivate var symbol: String {
        switch self {
        case .wei: return "WEI"
        case .kwei, .ada, .femtoether: return "KWEI"
        case .gwei, .shannon, .nanoether, .nano:  return "GWEI"
        case .szabo, .microether, .micro: return "MICRO"
        case .finney, .millether, .milli: return "MILLI"
        case .ether: return "ETH"
        case .kether, .grand, .einstein: return "KETH"
        case .mether: return "METH"
        case .gether: return "GETH"
        case .tether: return "TETH"
        }
    }
}

public extension Wei {
    
//    init(hex: String) {
//        
//    }
//    
//    public init(from decoder: Decoder) throws {
////        var products = [Product]()
////        let container = try decoder.container(keyedBy: ProductKey.self)
////        for key in container.allKeys {
////            // Note how the `key` in the loop above is used immediately to access a nested container.
////            let productContainer = try container.nestedContainer(keyedBy: ProductKey.self, forKey: key)
////            let points = try productContainer.decode(Int.self, forKey: .points)
////            let description = try productContainer.decodeIfPresent(String.self, forKey: .description)
////            
////            // The key is used again here and completes the collapse of the nesting that existed in the JSON representation.
////            let product = Product(name: key.stringValue, points: points, description: description)
////            products.append(product)
////        }
////        
////        self.init(products: products)
//    }
    
    /**
     
     - paramaters:
         - separators: if true, adds 
     */
    public func formattedBalance(unit: EthereumUnit, decimals: Int = 18, trimTrailingZeros: Bool = true, separators: Bool = true) -> String {
        return formattedBalance(coefficient: unit.factor, decimals: decimals, trimTrailingZeros: trimTrailingZeros, separators: separators)
    }
    
//    /**
//     prints
//     */
//    public func printable(unit: EthereumUnit, decimals: Int = 18, trimTrailingZeros: Bool = true) -> String {
//        
//        let quotient = (self / unit.factor).description
//        let remainder = (self % unit.factor).description.trim("0") 
//        
//        let x = "".trim("0")
////        let remainderString = remainder.
//        
//        print("Wei: \(self.description)")
//        print("\(quotient).\(remainder) \(unit.symbol)")
//        
//        return ""
//        
//        // ether
//    }
    
//    public init(_ value: BigInt, unit: EthereumUnit) {
//
//    }

}

