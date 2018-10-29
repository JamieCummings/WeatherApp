//
//  geoCodingData.swift
//  Weather app
//
//  Created by Jamie Cummings on 10/26/18.
//  Copyright © 2018 Jamie Cummings. All rights reserved.
//

import Foundation
import SwiftyJSON

class geoCodingData {
    // MARK:- Types
    // these are the keys that we will need to get the correct info from the Google Geocoding API
    
    enum GeocodingDataKeys: String {
        case results = "results"
        case formattedAddress = "formatted_address"
        case geometry = "geometry"
        case location = "location"
        case latitude = "latitude"
        case longitude = "longitude"
    }
    //MARK:- Properties
    
    var formattedAddress: String
    var latitude: Double
    var longitude: Double
    
    //MARK:- Methods
    // regular initializer
    init(formattedAddress: String, latitude: Double, longitude: Double){
        self.formattedAddress = formattedAddress
        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    // failable convenience init for breaking down data from JSON and creating GeocodingData
    convenience init?(json:JSON){
        guard let results  = json[GeocodingDataKeys.results.rawValue].array else {return nil
        }
        
        guard let formattedAddress = results[0][GeocodingDataKeys.formattedAddress.rawValue].string else { return nil
        }
        
        guard let latitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.latitude.rawValue].double else { return nil
        }
        guard let longitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.longitude.rawValue].double else { return nil
        }
        // since we were able to pull all the data we needed from the json, we are going to make a new instance of the geoCodingData class, so call the other initializer
        self.init(formattedAddress: formattedAddress, latitude: latitude, longitude: longitude)
    }
}
