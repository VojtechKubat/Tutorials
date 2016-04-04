//
//  ViewController.swift
//  Bow Ties
//
//  Created by Pietro Rea on 7/12/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var managedContext: NSManagedObjectContext!
  
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timesWornLabel: UILabel!
    @IBOutlet weak var lastWornLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!

    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
        insertSampleData()
        updateView()
        
    }
    
    func updateView () {
        guard segmentedControl != nil else {return}
        let request = NSFetchRequest(entityName: "Bowtie")
        
        let title = segmentedControl.titleForSegmentAtIndex(segmentedControl.selectedSegmentIndex)
        request.predicate = NSPredicate(format: "searchKey == \"\(title!)\"")
        
        do {
            let results : [AnyObject] = try managedContext.executeFetchRequest(request)
            
            (results.last as! Bowtie).printInfo()
        } catch let error as NSError {
            print(error)
        }
    }

    @IBAction func segmentedControl(control: UISegmentedControl) {
        updateView()
    }

    @IBAction func wear(sender: AnyObject) {

    }

    @IBAction func rate(sender: AnyObject) {

    }
    
    // insert sample data
    func insertSampleData () {
        let fetchRequest = NSFetchRequest(entityName: "Bowtie")
        fetchRequest.predicate = NSPredicate(format: "searchKey != nil")
        var count = managedContext.countForFetchRequest(fetchRequest, error: nil)
        
        // defer block will be executed after the function execution is done (return is called)
        defer {
            count = managedContext.countForFetchRequest(fetchRequest, error: nil)
            print("Count of bow ties: \(count)")
        }
        
        guard count == 0 else {return}
        
        let path = NSBundle.mainBundle().pathForResource("SampleData", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)
        
        guard dataArray != nil && dataArray?.count > 0 else {return}
        
        for current: AnyObject in dataArray! {
            
            let entity = NSEntityDescription.entityForName("Bowtie", inManagedObjectContext: managedContext)
            let bowtie = Bowtie(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            let btDict = current as! NSDictionary
            
            bowtie.name = btDict["imageName"] as? String
            bowtie.searchKey = btDict["searchKey"] as? String
            bowtie.rating = btDict["rating"] as? NSNumber
            
            let tintColorDict = btDict["tintColor"] as? NSDictionary
            bowtie.tintColor = Bowtie.colorFromDict(tintColorDict!)
            
            // image shall be stored in data blob form
            // 1 - get the image url; image are stored within the bundle assets
            let imageName = btDict["imageName"] as? String
            guard imageName != nil && imageName != "" else {print(">>> image name is missign: \(current.description)"); break}
 
            // 2 - create UIImage based on the url
            let image = UIImage(named: imageName!)
            guard image != nil else {print(">>> image was not found \(current.description)"); break}
            
            // 3 - get the data blob
            let photoData = UIImagePNGRepresentation(image!)
//            let photoData = UIImageJPEGRepresentation(image!, 0.8)
            bowtie.photoData = photoData
            
            bowtie.lastWorn = btDict["lastWorn"] as? NSDate
            bowtie.timesWorn = btDict["timesWorn"] as? NSNumber
            bowtie.isFavorite = btDict["isFavorite"] as? NSNumber
        
            do {
                try bowtie.managedObjectContext?.save()
            } catch let error as NSError {
                print("\(error)")
            }
        }
    }
    
    
    func populate(bt: Bowtie) {
        
    }
}