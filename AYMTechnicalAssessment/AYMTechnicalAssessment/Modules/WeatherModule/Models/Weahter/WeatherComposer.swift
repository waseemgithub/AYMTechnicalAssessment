//
//  WeatherComposer.swift
//  AYMTechnicalAssessment
//
//  Created by Waseem Shahzad on 9/2/18.
//  Copyright © 2018 Waseem Shahzad. All rights reserved.
//

import Foundation
struct WeatherComposer {
    var location: String?
    var weahterDescription:String?
    var iconText: String?
    var temperature: String?
    let weekDay:String?
    let humidity:String?
    let wind:String?
    let precipitation:String?
    
    var forecasts: [Forecast]?
    
    func compose() -> Weather {
        return Weather(location: location!,
                       weatherDescription: weahterDescription!,
                       iconText: iconText!,
                       temperature: temperature!, weekDay: weekDay!, humidity: humidity!, wind: wind!, precipitation: precipitation!,
                       forecasts: forecasts!)
    }
}
