//
//  SwifthereumError.swift
//  Swifthereum
//
//  Created by Ronald Mannak on 10/20/17.
//

import Foundation

enum SwifthereumError: Error {
    case invalidResource
    case serverError(Int, String)
    case encodingError
}
