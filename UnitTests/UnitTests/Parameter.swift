//
//  Parameter.swift
//  UnitTests
//
//  Created by Ronald Mannak on 10/24/17.
//  Copyright © 2017 Indisputable Labs. All rights reserved.
//

import Foundation

infix operator ∆

struct Parameter: Codable {
    let jsonrpc: String
    let method: String
    let params: [String]?
    let id: Int
}

extension Parameter: Equatable {
    static func == (lhs: Parameter, rhs: Parameter) -> Bool {
        let lhsIsEmpty = lhs.emptyParameters()
        let rhsIsEmpty = rhs.emptyParameters()
        
        if lhsIsEmpty != rhsIsEmpty { return false }
        
        return
            lhs.jsonrpc == rhs.jsonrpc &&
            lhs.method == rhs.method &&
            lhs.params ?? [] == rhs.params ?? []
    }
    
    // Returns Delta / Differnce between twee Parameter structs
    static func ∆ (lhs: Parameter, rhs: Parameter) -> String? {
        guard lhs != rhs else { return nil }
        var string = "Delta: "
        if lhs.jsonrpc != rhs.jsonrpc {
            string = string + "\(lhs.jsonrpc) != \(rhs.jsonrpc) "
        }
        if lhs.method != rhs.method {
            string = string + "\(lhs.method) != \(rhs.method) "
        }
        let lhsIsEmpty = lhs.emptyParameters()
        let rhsIsEmpty = rhs.emptyParameters()
        if lhsIsEmpty != rhsIsEmpty || lhs.params ?? [""] != rhs.params ?? [""] {
            string = string + "\(lhs.params ?? ["(nil)"]) != \(rhs.params ?? ["(nil)"])"
        }

        return string
    }
    
    private func emptyParameters() -> Bool {
        return self.params == nil || self.params?.isEmpty == true
    }
}

