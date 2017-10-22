//
//  TimeInterval.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    public var ethereumTime: (seconds: Int64, nanoseconds: Int64) {
        let seconds = Int64(self)
        let nanoSeconds = Int64(self - TimeInterval(seconds) * 1_000_000) // TODO: is this correct?
        return (seconds: seconds, nanoseconds: nanoSeconds)
    }
    
    public var nanoseconds: Int64 {
        return Int64(self * 1_000_000) // TODO: is this correct?
    }
}
