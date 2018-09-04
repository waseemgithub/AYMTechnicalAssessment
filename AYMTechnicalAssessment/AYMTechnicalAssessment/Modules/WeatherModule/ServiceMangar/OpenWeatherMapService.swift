//
//  OpenWeatherMapService.swift
//  AYMTechnicalAssessment
//
//  Created by Waseem Shahzad on 9/2/18.
//  Copyright © 2018 Waseem Shahzad. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

struct OpenWeatherMapService: WeatherServiceProtocol {
    fileprivate let urlPath = "http://api.openweathermap.org/data/2.5/forecast"
    
    fileprivate func getFirstFourForecasts(_ json: JSON) -> [Forecast] {
        var forecasts: [Forecast] = []

        if let values = json["list"].array {
            for index in values {
                guard let forecastTempMinDegrees = index["main"]["temp_min"].double,
                    let forecastTempMaxDegrees = index["main"]["temp_max"].double,
                    let rawDateTime = index["dt"].double,
                    let forecastCondition = index["weather"][0]["id"].int,
                    let forecastIcon = index["weather"][0]["icon"].string else {
                        break
                }
                let forecastTempMin = Temperature(country: "",
                                                      openWeatherTempWithSign: forecastTempMinDegrees)
                let forecastTempMax = Temperature(country: "",
                                                  openWeatherTempWithSign: forecastTempMaxDegrees)
                let forecastWeekDay = ForecastDateTime(date: rawDateTime, timeZone: TimeZone.current).shortWeekDay
                let forecastTime = ForecastDateTime(date: rawDateTime, timeZone: TimeZone.current).time
                let weatherIcon = WeatherIcon(condition: forecastCondition, iconString: forecastIcon)
                let forcastIconText = weatherIcon.iconText
                
                let forecast = Forecast(weekDay: forecastWeekDay, iconText: forcastIconText, tempMin: forecastTempMin.degrees, tempMax: forecastTempMax.degrees, time: forecastTime)
                
                forecasts.append(forecast)
            }
        }
       
        
        return forecasts
    }
    
    func retrieveWeatherInfo(_ location: CLLocation, completionHandler: @escaping WeatherCompletionHandler) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        guard let url = generateRequestURL(location) else {
            let error = AYMTAError(errorCode: .urlError)
            completionHandler(nil, error)
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            // Check network error
            guard error == nil else {
                let error = AYMTAError(errorCode: .networkRequestFailed)
                completionHandler(nil, error)
                return
            }
            
            // Check JSON serialization error
            guard let data = data else {
                let error = AYMTAError(errorCode: .jsonSerializationFailed)
                completionHandler(nil, error)
                return
            }
            
            guard let json = try? JSON(data: data) else {
                let error = AYMTAError(errorCode: .jsonParsingFailed)
                completionHandler(nil, error)
                return
            }
            
            // Get temperature, location and icon and check parsing error
            guard let tempDegrees = json["list"][0]["main"]["temp"].double,
                let country = json["city"]["country"].string,
                let city = json["city"]["name"].string,
                let weatherCondition = json["list"][0]["weather"][0]["id"].int,
                let iconString = json["list"][0]["weather"][0]["icon"].string,
                let weatherDescription = json["list"][0]["weather"][0]["description"].string,
                let rawDateTime = json["list"][0]["dt"].double,
                let humidity = json["list"][0]["main"]["humidity"].int,
                let wind = json["list"][0]["wind"]["speed"].int,
                let precipitation = json["list"][0]["clouds"]["all"].int
                else {
                    let error = AYMTAError(errorCode: .jsonParsingFailed)
                    completionHandler(nil, error)
                    return
            }
            
            let temperature = Temperature(country: country, openWeatherMapDegrees:Double(tempDegrees))
            let weatherIcon = WeatherIcon(condition: weatherCondition, iconString: iconString)
            let forecastTimeString = ForecastDateTime(date: rawDateTime, timeZone: TimeZone.current).weekDay
            let weatherComposer = WeatherComposer(location: city, weahterDescription: weatherDescription, iconText: weatherIcon.iconText, temperature: temperature.degrees, weekDay: forecastTimeString, humidity: String(humidity), wind: String(wind), precipitation: String(precipitation), forecasts: self.getFirstFourForecasts(json))
            completionHandler(weatherComposer.compose(), nil)
        }
        
        task.resume()
    }
    
    fileprivate func generateRequestURL(_ location: CLLocation) -> URL? {
        guard var components = URLComponents(string:urlPath) else {
            return nil
        }
        // get appId from Info.plist
        let filePath = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let parameters = NSDictionary(contentsOfFile:filePath)
        let appId = parameters!["OWMAccessToken"]! as! String
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        components.queryItems = [URLQueryItem(name:"lat", value:latitude),
                                 URLQueryItem(name:"lon", value:longitude),
                                 URLQueryItem(name:"appid", value:appId)]
        
        return components.url
    }
}
