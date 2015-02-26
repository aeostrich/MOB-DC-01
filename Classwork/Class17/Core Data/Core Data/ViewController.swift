//
//  ViewController.swift
//  Core Data
//
//  Created by Adam Ostrich on 2/25/15.
//  Copyright (c) 2015 Adam Ostrich. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let moc = appDelegate.managedObjectContext {
            var ena = NSEntityDescription.insertNewObjectForEntityForName("Animal", inManagedObjectContext: moc) as Animal
            ena.name = "Frank"
            ena.noise = "sup"
            ena.hasFur = true
            ena.numberOfLegs = 4
            
            self.appDelegate.saveContext()
        }
        else {
            println("Fuck your couch")
        }
    }
    
    @IBAction func pressButton(sender: UIButton) {
        if let moc = appDelegate.managedObjectContext {
            let fetch = NSFetchRequest(entityName: "Animal")
            let animalPredicate = NSPredicate(format: "name contains %@", "nk")
            fetch.predicate = animalPredicate
            
            // Define error before making call to database
            var error: NSError?
            
            // Retrieve array of the Animal object for each item/row we grab from the database
            let pants = moc.executeFetchRequest(fetch, error: &error)
            if let dogs: [Animal] = pants as? [Animal] {//moc.executeFetchRequest(fetch, error: &error) as? [Animal] {
                for dog in dogs {
                    println("Dog number \(find(dogs, dog)!)")
                    println("\tName: \(dog.name)")
                    println("\tNoise: \(dog.noise)")
                    println("\tHas fur: \(dog.hasFur)")
                    println("\tNumber of Legs: \(dog.numberOfLegs)")
                }
            }
            else {
                println(error?.localizedDescription)
            }
        }
        else {
            println("I hate you")
        }
    }
}

