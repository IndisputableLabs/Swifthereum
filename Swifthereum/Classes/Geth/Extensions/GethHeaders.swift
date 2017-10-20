//
//  GethHeaders.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/29/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

extension GethHeaders {
    
    open func array() throws -> [Header] {
        var headers = [Header]()
        for i in 0 ..< size() {
            let header = try Header(gethHeader: get(i))
            headers.append(header)
        }
        return headers
    }
}
