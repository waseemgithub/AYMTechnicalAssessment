//
//  ForecastViewModel.swift
//  AYMTechnicalAssessment
//
//  Created by Waseem Shahzad on 9/2/18.
//  Copyright © 2018 Waseem Shahzad. All rights reserved.
//

import Foundation
struct ForecastViewModel {
    let weekDay:String
    let iconText: String
    let tempMin: String
    let tempMax: String
    let time:String
    
    init(_ forecast: Forecast) {
        time = forecast.time
        iconText = forecast.iconText
        tempMin = forecast.tempMin
        tempMax = forecast.tempMax
        weekDay = forecast.weekDay
    }
}
