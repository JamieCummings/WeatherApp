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
        
        let apiManager = APIManager()
        
        apiManager.geocode(address: "Glasgow,+Kentucky"){ (data, error) in
            // if we get back an error
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {
                return
            }
            print(data.formattedAddress)
            print(data.latitude)
            print(data.longitude)
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

