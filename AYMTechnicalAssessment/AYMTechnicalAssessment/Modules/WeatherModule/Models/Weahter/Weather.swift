//
//  Weather.swift
//  AYMTechnicalAssessment
//
//  Created by Waseem Shahzad on 9/2/18.
//  Copyright © 2018 Waseem Shahzad. All rights reserved.
//

import Foundation

struct Weather {
    let location: String
    let weatherDescription:String
    let iconText: String
    let temperature: String
    let weekDay:String
    let humidity:String
    let wind:String
    let precipitation:String
    
    let forecasts: [Forecast]
}
