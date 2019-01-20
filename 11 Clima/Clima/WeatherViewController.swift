//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    // Constants
    let KELVIN_OFFSET = 273.15
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let weatherDataModel = WeatherDataModel()
    
    // README - Required!!!
    // Get API Key from the website https://openweathermap.org/appid and insert below
    let APP_ID = OPEN_WEATHER_MAP_API_KEY

    // Instance variables
    let locationManager = CLLocationManager()
    
    // Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - Networking
    /***************************************************************/
    func getWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got weather data.")
                
                let weatherJSON: JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
            }
            else {
                print("Error: \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection issue."
            }
        }
    }

    //MARK: - JSON Parsing
    /***************************************************************/
    func updateWeatherData(json: JSON) {
        
        if let temperature = json["main"]["temp"].double {
            weatherDataModel.temperature = Int(temperature - KELVIN_OFFSET)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateUIWithWeatherData()
        } 
        else {
            cityLabel.text = "Weather Unavailable"
        }

    }
    
    //MARK: - UI Updates
    /***************************************************************/
    func updateUIWithWeatherData() {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature) °"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            // Prevents receiving more than one location while stopping.
            locationManager.delegate = nil
            
            print("longitude: \(location.coordinate.longitude), latitude: \(location.coordinate.latitude)")
            
            getWeatherData(
                url: WEATHER_URL,
                parameters: [
                    "lat": String(location.coordinate.latitude),
                    "lon": String(location.coordinate.longitude),
                    "appid": APP_ID
                ]
            )
        }
    }

    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    func userEnteredANewCityName(name: String) {
        getWeatherData(
            url: WEATHER_URL,
            parameters: ["q": name, "appid": APP_ID]
        )
    }
    
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let changeCityViewController = segue.destination as! ChangeCityViewController
            changeCityViewController.delegate = self
        }
    }
 
}


