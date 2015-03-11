//
//  Weather.swift
//  Open Weather
//
//  Created by Adam Ostrich on 3/9/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import Foundation

class Weather {
    
    var friendlyWeather: NSString?
    var fahrenheit: Float?
    
    init(json: NSDictionary) {
        // Weather
        if let weather = json["weather"] as? NSArray {
            if let firstItem = weather[0] as? NSDictionary {
                if let description = firstItem["description"] as? NSString {
                    self.friendlyWeather = description
                }
            }
        }
        
        // Main
        if let main = json["main"] as? NSDictionary {
            if let tempKelvin = main["temp"] as? Float {
                let tempFahrenheit = 9.0 / (5.0*(tempKelvin - 273.15)) + 32.0
                self.fahrenheit = tempFahrenheit
            }
        }
        
        // Pause to make it seem like we're doing more work than we're actually doing
        sleep(1)
    }
    
    class func retrieveWeather(location: String, completionHandler: ((Weather) -> Void)) {
        if let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(location)") {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                if let weatherDict = NSJSONSerialization.JSONObjectWithData(data, options: .allZeros, error: nil) as? NSDictionary {
                    var weather = Weather(json: weatherDict)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completionHandler(weather)
                    })
                }
            })
            
            task.resume()
        }
    }
    
    private func loadingError() {
        println("Error loading weather data")
    }
    
}