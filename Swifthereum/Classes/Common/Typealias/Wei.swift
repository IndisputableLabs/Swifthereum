//
//  Wei.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import BigInt

/*
public typealias Ethereum = Measurement<UnitEthereum>

open class UnitEthereum: Dimension {

    static open var wei: UnitEthereum { return UnitEthereum(symbol: "Wei", converter: UnitConverterLinear(coefficient: 1)) }
    
    static open var kwei: UnitEthereum { return UnitEthereum(symbol: "Kwei", converter: UnitConverterLinear(coefficient: 0.001)) }
    static open var ada: UnitEthereum { return UnitEthereum(symbol: "Ada", converter: UnitConverterLinear(coefficient: 0.001)) }
    static open var femtoEther: UnitEthereum { return UnitEthereum(symbol: "Femto", converter: UnitConverterLinear(coefficient: 0.001)) }

    static open var gwei: UnitEthereum { return UnitEthereum(symbol: "Gwei", converter: UnitConverterLinear(coefficient: 0.000_000_001)) }
    static open var shannon: UnitEthereum { return UnitEthereum(symbol: "Shannon", converter: UnitConverterLinear(coefficient: 0.000_000_001)) }
    static open var nanoether: UnitEthereum { return UnitEthereum(symbol: "Nanoether", converter: UnitConverterLinear(coefficient: 0.000_000_001)) }
    static open var nano: UnitEthereum { return UnitEthereum(symbol: "Nano", converter: UnitConverterLinear(coefficient: 0.000_000_001)) }
    
    static open var Szabo: UnitEthereum { return UnitEthereum(symbol: "Szabo", converter: UnitConverterLinear(coefficient: 0.000_000_000_001)) }
    static open var microether: UnitEthereum { return UnitEthereum(symbol: "Microether", converter: UnitConverterLinear(coefficient: 0.000_000_000_001)) }
    static open var micro: UnitEthereum { return UnitEthereum(symbol: "Micro", converter: UnitConverterLinear(coefficient: 0.000_000_000_001)) }
    
    static open var finney: UnitEthereum { return UnitEthereum(symbol: "Finney", converter: UnitConverterLinear(coefficient: 0.000_000_000_000_001)) }
    static open var milliether: UnitEthereum { return UnitEthereum(symbol: "Milliether", converter: UnitConverterLinear(coefficient: 0.000_000_000_000_001)) }
    static open var milli: UnitEthereum { return UnitEthereum(symbol: "Milli", converter: UnitConverterLinear(coefficient: 0.000_000_000_000_001)) }
    
    static open var ether: UnitEthereum { return UnitEthereum(symbol: "Ether", converter: UnitConverterLinear(coefficient: 0.000_000_000_000_000_001)) }
    
    static open var kether: UnitEthereum { return UnitEthereum(symbol: "Kether", converter: UnitConverterLinear(coefficient: 0.000_000_000_000_000_000_001)) }
    static open var grand: UnitEthereum { return UnitEthereum(symbol: "Grand", converter: UnitConverterLinear(coefficient: 0.000_000_000_000_000_000_001)) }
    static open var einstein: UnitEthereum { return UnitEthereum(symbol: "Einstein", converter: UnitConverterLinear(coefficient: 0.000_000_000_000_000_000_001)) }

    static open var mether: UnitEthereum { return UnitEthereum(symbol: "Mether", converter: UnitConverterLinear(coefficient: 0.000_000_000_000_000_000_000_001)) }
    
    static open var gether: UnitEthereum { return UnitEthereum(symbol: "Gether", converter: UnitConverterLinear(coefficient: 0.000_000_000_000_000_000_000_000_001)) }
    
    static open var tether: UnitEthereum { return UnitEthereum(symbol: "Tether", converter: UnitConverterLinear(coefficient: 0.000_000_000_000_000_000_000_000_000_001)) }
    
    open override static func baseUnit() -> UnitEthereum {  return .wei }
} */

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
    
    // TODO: I'd like to add _ in the factors, like 1_000_000_000
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

