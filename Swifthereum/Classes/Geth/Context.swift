//
//  Context.swift
//  GethTest
//
//  Created by Ronald Mannak on 9/24/17.
//  Copyright © 2017 Indisputable. All rights reserved.
//

import Foundation
import Geth

/// Context carries a deadline, a cancelation signal, and other values across API boundaries.
public enum Context {
    
    /**
     returns a non-nil, empty Context. It is never canceled, has no
     values, and has no deadline. It is typically used by the main function,
     initialization, and tests, and as the top-level Context for incoming requests.
     */
    case empty
    /**
     WithCancel returns a copy of the original context with cancellation mechanism
     included.
     
     Canceling this context releases resources associated with it, so code should
     call cancel as soon as the operations running in this Context complete.
     */
    case cancel
    /**
     WithDeadline returns a copy of the original context with the deadline adjusted
     to be no later than the specified time.
     
     Canceling this context releases resources associated with it, so code should
     call cancel as soon as the operations running in this Context complete.
     */
    case deadline(timeInterval: TimeInterval)
    /**
     WithTimeout returns a copy of the original context with the deadline adjusted
     to be no later than now + the duration specified.
     
     Canceling this context releases resources associated with it, so code should
     call cancel as soon as the operations running in this Context complete.
     */
    case timeOut(timeInterval: TimeInterval)
    
    public var _gethContext: GethContext {
        switch self {
        case .empty:
            return GethNewContext()
        case .cancel:
            return GethNewContext().withCancel()
        case .deadline(let timeInterval):
            return GethNewContext().withDeadline(timeInterval.ethereumTime.seconds, nsec: timeInterval.ethereumTime.nanoseconds)
        case .timeOut(let timeInterval):
            return GethNewContext().withTimeout(timeInterval.nanoseconds)
        }
    }
}
