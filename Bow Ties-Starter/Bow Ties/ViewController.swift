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
    var currentBowtie: Bowtie!
  
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
        
        // use predicate to get the right Bowtie object
        let index = segmentedControl.titleForSegmentAtIndex(segmentedControl.selectedSegmentIndex)
        request.predicate = NSPredicate(format: "searchKey == \"\(index!)\"")
        
        do {
            let results : [AnyObject] = try managedContext.executeFetchRequest(request)
            // resutlt contains [AnyOjbect] array, so in case, there are more than one results, only the last one will be used (this should not happen)
            if (results.count > 1) {
                print(">>> WARNING >>> there are multiple results for predicate, something doesn't went as expected.\n" +
                    ">>> there are \(results.count) results, but only one was expected")
            }
            (results.last as! Bowtie).printInfo()
            currentBowtie = results.last as! Bowtie
            populate()
//            populate(results.last as! Bowtie)
        } catch let error as NSError {
            print(error)
        }
    }

    @IBAction func segmentedControl(control: UISegmentedControl) {
        updateView()
    }

    @IBAction func wear(sender: AnyObject) {
        let times = currentBowtie.timesWorn!.integerValue
        currentBowtie.timesWorn = NSNumber(integer: times + 1)
        currentBowtie.lastWorn = NSDate()
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        populate()
    }

    @IBAction func rate(sender: AnyObject) {
        let alert = UIAlertController(title: "New ratinf",
                                      message: "Rate this bow tie",
                                      preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .Cancel,
                                         handler: {(action: UIAlertAction) in
                                            
        })
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .Default,
                                       handler: {(action: UIAlertAction) in
                                            let textField = alert.textFields![0] as UITextField
                                            self.updateRating(textField.text)
        })
        
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField) in
            textField.keyboardType = .NumberPad
        })
        
//        alert.view.frame = UIScreen.mainScreen().bounds
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        presentViewController(alert,
                              animated: true,
                              completion: nil)
        
        print(">>> alert subviews: \(alert.view.subviews.description)")
    }
    
    // insert sample data
    func insertSampleData () {
        let fetchRequest = NSFetchRequest(entityName: "Bowtie")
        fetchRequest.predicate = NSPredicate(format: "searchKey != nil")
        var count = managedContext.countForFetchRequest(fetchRequest, error: nil)
        
        // defer block will be executed after the function execution is done (return is called)
        defer {
            print("There are already some bowties in the database. Count of bow ties: \(count)")
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
    
    func populate() {
        guard currentBowtie != nil else {return}
        
        imageView.image = UIImage(data: currentBowtie.photoData!)
        nameLabel.text = currentBowtie.name
        ratingLabel.text = "Rating: \(currentBowtie.rating!.doubleValue)/5"
        timesWornLabel.text = "# times worn: \(currentBowtie.timesWorn!.integerValue))"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeZone = .None
        
        lastWornLabel.text = "Last worn: \(dateFormatter.stringFromDate(currentBowtie.lastWorn!)))"
        
        favoriteLabel.hidden = !currentBowtie.isFavorite!.boolValue
        
        view.tintColor = currentBowtie.tintColor as! UIColor
    }
    
    func updateRating(numericString: String?) {
        if let newRating: NSString = numericString {
            currentBowtie.rating = newRating.doubleValue
            
            do {
                try managedContext.save()
                populate()
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
                if error.domain == NSCocoaErrorDomain &&
                    (error.code == NSValidationNumberTooLargeError ||
                        error.code == NSValidationNumberTooSmallError) {
                    rate(currentBowtie)
                }
            }
        }
    }
}