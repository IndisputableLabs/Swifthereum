//
//  Error.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/30/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation

enum SwifthereumError: Error {
    case invalidJSON
    case invalidRLP
    case invalidAddress
    case invalidPath
    case networkError
    case fileError
}
