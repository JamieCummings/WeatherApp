//
//  APIManager.swift
//  Weather app
//
//  Created by Jamie Cummings on 10/29/18.
//  Copyright © 2018 Jamie Cummings. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager{
    // base URL for the Dark sky API
    private let darkSkyURL = "https://api.darksky.net/forecast/"
    // base URL for the Google Geocoding API
    private let googleBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
    //Instance of the APIKeys struct
    private let apiKeys = APIKeys()
    
    // this is an Enum containing diff srrors we could get from trying to connect to an API
    enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
    }
    
    func getWeather(latitude: Double, longitude: Double, onCompletion: @escaping (WeatherData?, Error?)-> Void){
        
        let url = darkSkyURL + apiKeys.darkSkyKey + "/" + "\(latitude)" + "," + "\(longitude)"
        
        let request = Alamofire.request(url)
        
        request.responseJSON {response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                print(json)
                
                // if the JSON can be converted into Weather data, call the completion closure by passing in thge weather data and nil for the error
                
                if let weatherData = WeatherData(json: json){
                    onCompletion(weatherData,nil)
                } else {
                    onCompletion(nil,APIErrors.invalidData)
                }
                
            case.failure(let error):
                onCompletion(nil,error)
            }
        }
    }
    // attempt to geocode that address that's passed in. afterward, call the onComplete closure by passing in geocoding data or an error
    func geocode(address: String, onCompletion: @escaping (GeoCodingData?, Error?) -> Void) {
        let url = googleBaseURL + address + "&key=" + apiKeys.googleKey
        
        // an alamofire request made from that URL
        let request = Alamofire.request(url)
        
        request.responseJSON { response in switch response.result {
        case .success(let value):
            let json = JSON(value)
           // if JSON can be converted into GeoCoding data call the completion closure 
            if let geocodingData = GeoCodingData(json: json){
                onCompletion(geocodingData,nil)
            } else {
                onCompletion(nil,APIErrors.invalidData)
            }
        case .failure(let error):
            onCompletion(nil,error)
            }
            
        }
        
    }
    
}
