//
//  ViewController.swift
//  Weather app
//
//  Created by Jamie Cummings on 10/25/18.
//  Copyright © 2018 Jamie Cummings. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let apiKeys = APIKeys()
        
        let darkSkyURL = "https://api.darksky.net/forecast/"
        let darkSkyKey = apiKeys.darkSkyKey
        let latitude = "37.004842"
        let longitude = "-85.925876"
        
        let url = darkSkyKey + darkSkyURL +  "/" + latitude + "," + longitude
        
        let request = Alamofire.request(url)
        // carrying out our request
        request.responseJSON { response in
            // switching based on the result of the request 
            switch response.result {
            case .success(let value):
                // if our request succeeds, take the value and convert it into a JSON object
                let json = JSON(value)
                // print out the JSON object
                print(json)
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
    
    
}

