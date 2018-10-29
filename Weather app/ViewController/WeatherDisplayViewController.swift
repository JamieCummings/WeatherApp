//
//  WeatherDisplayViewController.swift
//  Weather app
//
//  Created by Jamie Cummings on 10/25/18.
//  Copyright © 2018 Jamie Cummings. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherDisplayViewController: UIViewController {
    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
        //when the screen 1st loads, set the default values for the ui
        setupDefaultUI()
        
        let apiKeys = APIKeys()
        
        let darkSkyURL = "https://api.darksky.net/forecast/"
        let darkSkyKey = apiKeys.darkSkyKey
        let latitude = "37.004842"
        let longitude = "-85.925876"
        
        let url = darkSkyURL + darkSkyKey + "/" + latitude + "," + longitude
        
        let request = Alamofire.request(url)
        // carrying out our request
        request.responseJSON { response in
            // switching based on the result of the request 
            switch response.result {
            case .success(let value):
                // if our request succeeds, take the value and convert it into a JSON object
                let json = JSON(value)
                let exampleWeatherData = WeatherData(json:json)
                print (exampleWeatherData?.temperature)
                print (exampleWeatherData?.highTemperature)
                print(exampleWeatherData?.lowTemperature)
                print (exampleWeatherData?.condition.icon)
                
                
                // print out the JSON object
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        let googleBaseURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
        let googleRequestURL = googleBaseURL + "Glasgow,+Kentucky" + "&key=" + apiKeys.googleKey
        let googleRequest = Alamofire.request(googleRequestURL)
        
        googleRequest.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    // this func will give the UI some default whenever we first load the app
    func setupDefaultUI() {
        locationLabel.text = "Emerald City,The Land of Oz"
        iconLabel.text = "🌈"
        currentTempLabel.text = "80º"
        lowTempLabel.text = "65º"
        highTempLabel.text = "85º"
    }
    
    
}

