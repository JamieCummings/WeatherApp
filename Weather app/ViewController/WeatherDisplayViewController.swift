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
    
    
    var displayWeatherData: WeatherData! {
        didSet {
            iconLabel.text = displayWeatherData.condition.icon
            currentTempLabel.text = "\( displayWeatherData.temperature)º"
            highTempLabel.text = "\(displayWeatherData.highTemperature)º"
            lowTempLabel.text = "\(displayWeatherData.lowTemperature)º"
        }
    }
    var displayGeocodingData: GeoCodingData! {
        didSet{
            locationLabel.text = displayGeocodingData.formattedAddress
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
        //when the screen 1st loads, set the default values for the ui
        setupDefaultUI()
        
        
        
    }
        
    // this func will give the UI some default whenever we first load the app
    func setupDefaultUI() {
        locationLabel.text = "Emerald City,The Land of Oz"
        iconLabel.text = "🌈"
        currentTempLabel.text = "80º"
        lowTempLabel.text = "65º"
        highTempLabel.text = "85º"
    }
    
    // unwind action so that we can unwind to this screen after retrieving data
    @IBAction func unwindToWeatherDisplay(segue: UIStoryboardSegue) { }
    
}

