//
//  Parameter.swift
//  UnitTests
//
//  Created by Ronald Mannak on 10/24/17.
//  Copyright © 2017 Indisputable Labs. All rights reserved.
//

import Foundation

struct Parameter: Codable {
    let jsonrpc: String
    let method: String
    let params: [String]?
    let id: Int
}

extension Parameter: Equatable {
    static func == (lhs: Parameter, rhs: Parameter) -> Bool {
        return
            lhs.jsonrpc == rhs.jsonrpc &&
            lhs.method == rhs.method &&
            lhs.params ?? [] == rhs.params ?? []
    }
}
