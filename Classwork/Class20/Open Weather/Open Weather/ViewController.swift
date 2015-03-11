//
//  ViewController.swift
//  Open Weather
//
//  Created by Adam Ostrich on 3/9/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherDescription: UILabel!
    
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    
    
    
    @IBAction func updateWeather(sender: UIButton) {
        let location = self.cityField.text.lowercaseString + "," + self.stateField.text.lowercaseString
        self.weatherDescription.text = "Loading data..."
        
        Weather.retrieveWeather(location) { (weather) -> Void in
            if let description = weather.friendlyWeather {
                if let fahrenheit = weather.fahrenheit {
                    self.weatherDescription.text = NSString(format: "\(description), %.1f° F", fahrenheit)
                } else { self.loadingError() }
            } else { self.loadingError() }
        }
    }
    
    func loadingError() {
        self.weatherDescription.text = "Error loading data!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = "washington,dc"
        self.weatherDescription.text = "Loading data..."
        
        Weather.retrieveWeather(location) { (weather) -> Void in
            if let description = weather.friendlyWeather {
                if let fahrenheit = weather.fahrenheit {
                    self.weatherDescription.text = NSString(format: "\(description), %.1f° F", fahrenheit)
                } else { self.loadingError() }
                } else { self.loadingError() }
        }
    }
}

