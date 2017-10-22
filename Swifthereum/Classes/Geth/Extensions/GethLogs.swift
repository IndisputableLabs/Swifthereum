//
//  GethLogs.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/29/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

extension GethLogs {
    
    open func arrays() throws -> [Log] {
        var array: [Log] = []
        for i in 0 ..< size() {
            let item = try get(i)
            let log = try Log(gethLog: item)
            array.append(log)
        }
        return array
    }
}
