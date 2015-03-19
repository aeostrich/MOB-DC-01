//
//  ViewController.swift
//  Maps
//
//  Created by Tedi Konda on 3/18/15.
//  Copyright (c) 2015 Tedi Konda. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    let locman = CLLocationManager()
    let searchRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Type of view (i.e. standard of satellite imagery)
        self.map.mapType = MKMapType.Standard
        
        // Hard-coded just so there's a default before we
        //  actually get the current location
        let initialLocation = CLLocation(latitude: 38.9059246844043, longitude: -77.0405378379645)
        self.centerMapOnLocation(initialLocation)
        
        // Set current VC as map delegate
        self.map.delegate = self
        
        // Set current VC as locaman delegate
        self.locman.delegate = self
        self.locman.desiredAccuracy = kCLLocationAccuracyBest
        self.locman.activityType = CLActivityType.Fitness
        self.locman.startUpdatingLocation()
    }
    
    func determineLocationStatus() -> Bool {
        let isOk = CLLocationManager.locationServicesEnabled()
        if !isOk {
            return true
        }
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
            case CLAuthorizationStatus.AuthorizedAlways, CLAuthorizationStatus.AuthorizedWhenInUse:
                return true
            case .NotDetermined:
                self.locman.requestWhenInUseAuthorization()
                return true
            case .Restricted:
                return false
            // Good place to re-request access to location
            case .Denied:
                return false
            default:
                return false
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("Updated location!")
        let loc = locations.last as CLLocation
        let coordinates = loc.coordinate
        
        println("You are currently at \(coordinates.latitude),\(coordinates.longitude)")
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, self.searchRadius * 2.0, self.searchRadius * 2.0)
        self.map.setRegion(coordinateRegion, animated: true)
    }

    
    @IBAction func showCurrentLoction(sender: UIButton) {
        self.locman.requestWhenInUseAuthorization()
        
        self.map.userTrackingMode = MKUserTrackingMode.Follow
    }
    
    
    @IBAction func geocodeAddress(sender: UIButton) {
        // Retrieve current location on the map
        let loc = self.map.userLocation.location
        
        // Error checking in case we don't have the location
        if loc == nil {
            println("I dont' know where you are, yo")
            return
        }
        
        let geocode = CLGeocoder()
        geocode.reverseGeocodeLocation(loc, completionHandler: { (placemarks: [AnyObject]!, error: NSError!) -> Void in
            if placemarks != nil {
                let placemark = placemarks[0] as CLPlacemark
                let address = ABCreateStringWithAddressDictionary(placemark.addressDictionary, false)
                
                println("You are at:\n\(address)")
            }
        })
    }
    
    
    @IBAction func findFood(sender: UIButton) {
        if !determineLocationStatus() {
            println("No food for you!  You disabled location")
            return
        }
        
        let userLoc = self.map.userLocation
        let loc = userLoc.location
        
        if loc == nil {
            println("I don't know where you are")
            return
        }
        
        let searchReq = MKLocalSearchRequest()
        searchReq.naturalLanguageQuery = "pizza"
        searchReq.region = self.map.region
        
        let search = MKLocalSearch(request: searchReq)
        search.startWithCompletionHandler { (response: MKLocalSearchResponse!, error: NSError!) -> Void in
            if response == nil {
                println(error)
                return
            }
            
            // Temporarily hide the current location so it doesn't
            //  conflict with search results
            self.map.showsUserLocation = false
            // response.mapItems -> Array of things we got back
            // Feeling lucky!
            let pizzaPlace = response.mapItems[0] as MKMapItem
            let place = pizzaPlace.placemark
            let loc = place.location.coordinate
            // long and lat distances are both radii
            let region = MKCoordinateRegionMakeWithDistance(loc, 1200, 1200)
            self.map.setRegion(region, animated: true)
            let pizzaEna = MKPointAnnotation()
            pizzaEna.title = place.title
            pizzaEna.subtitle = pizzaPlace.phoneNumber
            pizzaEna.coordinate = loc
            
//            self.map.addAnnotation(pizzaEna)
            
            // Can also use a class to do this
            let restaurant = Restaurant(title: pizzaPlace.name, locationName: pizzaPlace.name, coordinate: loc)
            self.map.addAnnotation(restaurant)
        }
    }
    
    
    @IBAction func getDirectionsToFood(sender: UIButton) {

    }
    
    
    @IBAction func showLocationInMapsApp(sender: UIButton) {
        let mapItem = MKMapItem.mapItemForCurrentLocation()
        mapItem.openInMapsWithLaunchOptions([MKLaunchOptionsMapTypeKey: MKMapType.Standard.rawValue])
    }
}

