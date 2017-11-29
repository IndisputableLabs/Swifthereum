//
//  Equatable.swift
//  BigInt
//
//  Created by Ronald Mannak on 11/28/17.
//

import Foundation

// https://stackoverflow.com/questions/36066762/most-elegant-way-to-compare-two-optionals-in-swift

func ==? <T: Equatable>(lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs == rhs
    } else {
        return lhs == nil && rhs == nil
    }
}

func ==? <T: AnyObject>(lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs === rhs
    } else {
        return lhs == nil && rhs == nil
    }
}

infix operator ==? : ComparisonPrecedence
