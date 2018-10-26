//
//  WeatherData.swift
//  Weather app
//
//  Created by Jamie Cummings on 10/26/18.
//  Copyright © 2018 Jamie Cummings. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherData {
    //Mark:- Types
    enum Condition: String {
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case rain = "rain"
        case snow = "snow"
        case sleet = "sleet"
        case wind = "wind"
        case fog = "fog"
        case cloudy = "cloudy"
        case partlyCloudyDay = "partly-cloudy-day"
        case partlyCloudyNight = "partly-cloudy-night"
        
        var icon: String{
            switch self{
                // switch based on the value of the enum
            case .clearDay:
                return "☀️"
            case .clearNight:
                return "🌝"
            case .rain:
                return "🌧"
            case .snow:
                return "☃️"
            case .sleet:
                return "🌨"
            case .wind:
                return "🌬"
            case .fog:
                return "💨"
            case .cloudy:
               return "☁️"
            case .partlyCloudyDay:
                return "🌥"
            case .partlyCloudyNight:
                return "🌗"
            }
        }
    }
    
    enum WeatherDataKeys: String {
        case currently = "currently"
        case daily = "daily"
        case temperature = "temperature"
        case icon = "icon"
        case data = "data"
        case temperatureHigh = "temperatureHigh"
        case temperatureLow = "temperatureLow"
        
    }
    
    
    
    // mark:- properties
    
    let temperature : Double
    let highTemperature: Double
    let lowTemperature: Double
    let condition: Condition
    
    // Mark:- Methods
    
    init(temperature:Double, highTemperature: Double, lowTemperature: Double, condition: Condition){
        self.temperature = temperature
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
        self.condition = condition
    }
    
    convenience init?(json:JSON){
        guard let temperature = json[WeatherDataKeys.currently.rawValue][WeatherDataKeys.temperature.rawValue].double else{
            return nil
        }
        guard let highTemperature =
            json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureHigh.rawValue].double else{
                return nil
        }
        guard let lowTemperature = json[WeatherDataKeys.daily.rawValue][WeatherDataKeys.data.rawValue][0][WeatherDataKeys.temperatureLow.rawValue].double else{
            return nil
        }
        guard let conditionString = json[WeatherDataKeys.currently.rawValue][WeatherDataKeys.icon.rawValue].string else{
            return nil
        }
        // take the string we got back from the json and use it to initialize an instance of the condition
        guard let  condition = Condition(rawValue: conditionString) else {
            return nil
        }
        
        // since we were able to pull all the data we needed from the json, we are going to make a new instance of the WeatherData class, so call the other initializer 
        self.init(temperature: temperature, highTemperature: highTemperature, lowTemperature: lowTemperature, condition: condition)
    }
    
}
