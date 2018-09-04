//
//  Error.swift
//  AYMTechnicalAssessment
//
//  Created by Waseem Shahzad on 9/2/18.
//  Copyright © 2018 Waseem Shahzad. All rights reserved.
//

import Foundation
struct AYMTAError {
    enum Code: Int {
        case urlError                 = -1000
        case networkRequestFailed     = -1001
        case jsonSerializationFailed  = -1002
        case jsonParsingFailed        = -1003
        case unableToFindLocation  = -1004
    }
    let errorCode: Code
}
