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
        case unableToFindLocation  = 1000
    }
    let errorCode: Code
}
