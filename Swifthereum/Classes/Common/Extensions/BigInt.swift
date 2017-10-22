//
//  BigInt.swift
//  GethTest
//
//  Created by Ronald Mannak on 10/6/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import BigInt

public extension BigInt {
    
    /**
     returns formatted balance
     */
    public func formattedBalance(coefficient: BigInt, decimals: Int = 18, trimTrailingZeros: Bool = true, separators: Bool = true) -> String {
        
        let decimalMark = Locale.current.decimalSeparator ?? ","
        let groupingSeparator = Locale.current.groupingSeparator ?? "."
        
        var quotient = (self / coefficient).description
        var remainder = (self % coefficient).description
        
        if separators == true {
            quotient = quotient.insert(seperator: groupingSeparator, afterEvery: 3)
        }
        if trimTrailingZeros == true {
            remainder = remainder.trim("0")
        }
        if remainder.count > 0 {
            remainder = decimalMark + remainder
        }
        
        return quotient + remainder
    }
}
