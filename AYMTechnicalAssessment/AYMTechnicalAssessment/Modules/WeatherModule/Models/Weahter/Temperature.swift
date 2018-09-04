//
//  Temperature.swift
//  AYMTechnicalAssessment
//
//  Created by Waseem Shahzad on 9/2/18.
//  Copyright © 2018 Waseem Shahzad. All rights reserved.
//

import Foundation
struct Temperature {
    let degrees: String
    
    init(country: String, openWeatherMapDegrees: Double) {
        if country == "US" {
            degrees = String(Int(Utility.kelvinToFahrenheit(openWeatherMapDegrees)))
            
        } else {
            degrees = String(Int(Utility.kelvinToCelsius(openWeatherMapDegrees)))
        }
    }
    init(country: String, openWeatherTempWithSign: Double) {
        if country == "US" {
            degrees = String(Int(Utility.kelvinToFahrenheit(openWeatherTempWithSign))) + "\u{f045}"
        } else {
            degrees = String(Int(Utility.kelvinToCelsius(openWeatherTempWithSign))) + "\u{f03c}"
        }
    }
    
}
