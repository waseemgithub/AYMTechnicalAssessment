//
//  WeatherViewModel.swift
//  AYMTechnicalAssessment
//
//  Created by Waseem Shahzad on 9/2/18.
//  Copyright © 2018 Waseem Shahzad. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherViewModel {
    // MARK: - Constants
    fileprivate let emptyString = ""
    
    // MARK: - Properties
    let hasError: Observable<Bool>
    let errorMessage: Observable<String?>
    
    let location: Observable<String>
    let iconText: Observable<String>
    let temperature: Observable<String>
    let weatherDesc: Observable<String>
    let weekDay: Observable<String>
    let humidity: Observable<String>
    let percipitation: Observable<String>
    let wind:Observable<String>
    let forecasts: Observable<[ForecastViewModel]>
    
    // MARK: - Services
    fileprivate var locationService: LocationService
    fileprivate var weatherService: WeatherServiceProtocol
    
    // MARK: - init
    init() {
        hasError = Observable(false)
        errorMessage = Observable(nil)
        
        location = Observable(emptyString)
        iconText = Observable(emptyString)
        temperature = Observable(emptyString)
        weatherDesc = Observable(emptyString)
        weekDay = Observable(emptyString)
        humidity = Observable(emptyString)
        percipitation = Observable(emptyString)
        wind = Observable(emptyString)
        forecasts = Observable([])
        
        // Can put Dependency Injection here
        locationService = LocationService()
        weatherService = OpenWeatherMapService()
    }
    
    // MARK: - public
    func startLocationService() {
        locationService.delegate = self
        locationService.requestLocation()
    }
    
    func convertTempFromCelsiusToFahrenheit() {
        if !UserDefaults.standard.bool(forKey: UserDefaultKeys.degreeTemp){
            let unit:NSString = self.temperature.value as NSString
            let celsiusUnit  = Utility.fahrenheitToCelsius(unit.doubleValue)
            let celsiusUnitString = String(Int(celsiusUnit))
            self.update(value: celsiusUnitString)
            UserDefaults.standard.set(false, forKey: UserDefaultKeys.fahrenheitTemp)
            UserDefaults.standard.set(true, forKey: UserDefaultKeys.degreeTemp)
            UserDefaults.standard.synchronize()
            
        }
    }
    func convertTempFromFahrenheitToCelsius(){
        if !UserDefaults.standard.bool(forKey: UserDefaultKeys.fahrenheitTemp){
            let unit:NSString = self.temperature.value as NSString
            let fahrenUnit  = Utility.celsiusToFahrenheit(unit.doubleValue)
            let fahrenUnitString = String(Int(fahrenUnit))
            self.update(value: fahrenUnitString)
            UserDefaults.standard.set(false, forKey: UserDefaultKeys.degreeTemp)
            UserDefaults.standard.set(true, forKey: UserDefaultKeys.fahrenheitTemp)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    
    // MARK: - private
    
    fileprivate func update(value: String){
        temperature.value = value
    }
    fileprivate func update(_ weather: Weather) {
        hasError.value = false
        errorMessage.value = nil
        
        location.value = weather.location
        iconText.value = weather.iconText
        temperature.value = weather.temperature
        weatherDesc.value = weather.weatherDescription
        weekDay.value = weather.weekDay
        humidity.value = weather.humidity
        wind.value = weather.wind
        percipitation.value = weather.precipitation
        
        let tempForecasts = weather.forecasts.map { forecast in
            return ForecastViewModel(forecast)
        }
        forecasts.value = tempForecasts
    }
    
    fileprivate func update(_ error: AYMTAError) {
        hasError.value = true
        
        switch error.errorCode {
        case .urlError:
            errorMessage.value = ErrorMessages.urlError
        case .networkRequestFailed:
            errorMessage.value = ErrorMessages.networkRequestFailed
        case .jsonSerializationFailed:
            errorMessage.value = ErrorMessages.jsonSerializationFailed
        case .jsonParsingFailed:
            errorMessage.value = ErrorMessages.jsonParsingFailed
        case .unableToFindLocation:
            errorMessage.value = ErrorMessages.unableToFindLocation
        }
        
        location.value = emptyString
        iconText.value = emptyString
        temperature.value = emptyString
        weatherDesc.value = emptyString
        weekDay.value = emptyString
        wind.value = emptyString
        humidity.value = emptyString
        percipitation.value = emptyString
        
        self.forecasts.value = []
    }
}

// MARK: LocationServiceDelegate
extension WeatherViewModel: LocationServiceDelegate {
    func locationDidUpdate(_ service: LocationService, location: CLLocation) {
        weatherService.retrieveWeatherInfo(location) { (weather, error) -> Void in
            DispatchQueue.main.async(execute: {
                if let unwrappedError = error {
                    print(unwrappedError)
                    self.update(unwrappedError)
                    return
                }
                
                guard let unwrappedWeather = weather else {
                    return
                }
                self.update(unwrappedWeather)
            })
        }
    }
    
    func locationDidFail(withError error: AYMTAError) {
        self.update(error)
    }
}
