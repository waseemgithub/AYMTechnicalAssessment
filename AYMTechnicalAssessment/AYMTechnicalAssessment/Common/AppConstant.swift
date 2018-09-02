//
//  AppConstant.swift
//  AYMTechnicalAssessment
//
//  Created by Waseem Shahzad on 9/2/18.
//  Copyright © 2018 Waseem Shahzad. All rights reserved.
//

import Foundation
import UIKit

//MARK: Storyboard Path
struct StoryBoard {
    static let main              =   UIStoryboard(name: "Main", bundle: nil)
    static let Restaurant               =   UIStoryboard(name: "Restaurant", bundle: nil)
    static let Weather               =   UIStoryboard(name: "Weather", bundle: nil)
}
//MARK: App Theme Color
struct AppColors {
    static let AppThemeColor = UIColor(displayP3Red: 239/255.0, green: 213/255.0, blue: 177.0/255.0, alpha: 1)
    static let AppActionsColor = UIColor(displayP3Red: 192.0/255.0, green: 159.0/255.0, blue: 109.0/255.0, alpha: 1)
    static let AppActionsTitleColor = UIColor.white
    static let WeatherDarkColor = UIColor(displayP3Red: 85.0/255.0, green: 68.0/255.0, blue: 42.0/255.0, alpha: 1)
    static let WeatherDarkMediumColor = UIColor(displayP3Red: 130.0/255.0, green: 102.0/255.0, blue: 63.0/255.0, alpha: 1)
}
//MARK: App Strings
struct AppStrings {
    static let WeatherActionTitle = "WEATHER MODULE"
    static let RestaurantActionTitle = "RESTAURANT MODULE"
    static let WeatherController = "WeatherViewController"
    static let RestaurantController = "RestaurantsViewController"
}

