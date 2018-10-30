//
//  LocationSelectViewController.swift
//  Weather app
//
//  Created by Jamie Cummings on 10/26/18.
//  Copyright © 2018 Jamie Cummings. All rights reserved.
//

import UIKit

class LocationSelectViewController: UIViewController,UISearchBarDelegate {
    
    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    
    // INSTANCE OF THE API MANAGER CLASS SO WE CAN MAKE API CALLS ON THIS SCREEN
    let apiManager = APIManager()
    
    var geocodingData: GeoCodingData?
    var weatherData: WeatherData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationSearchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    // if something goes wrong with one of the api calls, call this to make sure we arent holding on to any geododing or weather
    func handleError(){
        geocodingData = nil
        weatherData = nil
    }
    
    func retrieveGeocodoingData(searchAddress: String){
        apiManager.geocode(address: searchAddress)
        { (geocodingData, error) in
            // if we receive and error, print out the error's localized description, call the handleError function and return
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handleError()
                return
            }
            // if we received geododig data, assign it to the geocodingData property and then make a Dark Sky call
            if let receivedData = geocodingData {
                self.geocodingData = receivedData
                // use that data to make a Dark Sky call
                self.retrieveWeatherData(latitude: receivedData.latitude, longitude: receivedData.longitude)
            } else {
                self.handleError()
                return
            }
        }
    }
    func retrieveWeatherData(latitude: Double, longitude: Double) {
        apiManager.getWeather(latitude: latitude, longitude: longitude) { (weatherData, error)in
            if let receivedError = error {
                print(receivedError.localizedDescription)
                self.handleError()
                return
            }
            if let receivedData = weatherData {
                self.weatherData = receivedData
                // TODO: this is where we need to segue back to the main screen
                self.performSegue(withIdentifier: "unwindToWeatherDisplay", sender: self)
            } else {
                self.handleError()
                return
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // try to replace the spaces in the search bar text with + signs. if you cant, stop running the function
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with:"+") else {
            return
        }
        retrieveGeocodoingData(searchAddress: searchAddress)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as?
            WeatherDisplayViewController, let retrieveGeocodingData =
            geocodingData, let retrievedWeatherData = weatherData {
            destinationVC.displayGeocodingData = retrieveGeocodingData
            destinationVC.displayWeatherData = retrievedWeatherData
            
        }
        
    }

}

