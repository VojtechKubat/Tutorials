//
//  ViewController.swift
//  CoreDataTutorial
//
//  Created by Vojtech Kubat on 3/8/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var names = [String]()
    var items = [NSManagedObject]()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Item")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            self.items = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        title = "The List"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "Add new name",
            message: "Type in a new name, you want to add.",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default,
            handler: {(action: UIAlertAction) -> Void in
                let textField = alert.textFields!.first
                self.saveItem(textField!.text!)
//                self.names.append(textField!.text!)
                self.tableView.reloadData()
            }
        )
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default,
            handler: {(alert: UIAlertAction) -> Void in
                
            }
        )

        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        alert.view.setNeedsLayout()
        
        presentViewController(alert,
            animated: true,
            completion: nil)
        
    }
    
    func saveItem(name:String) {
        // managedContext was created in AppDelegate "Core Data Stack"
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext


        // based on the managedContext, a specific entity description is received, and based on it a new ManagedObject is created
        let entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: managedContext)
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        // relevant data are assigned to the new ManagedObject
        item.setValuesForKeysWithDictionary(["name": name])
        
        // all changes are commited
        do {
            try managedContext.save()
            items.append(item)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

// ---------------------------------------------------------
// MARK: UITableViewDataSource
// ---------------------------------------------------------
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell")
        
        let item = items[indexPath.row]
        
        cell?.textLabel?.text = item.valueForKey("name") as? String
        
        return cell!
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 90.0
//    }
    
// ---------------------------------------------------------
// MARK: UITableViewDelegate
// ---------------------------------------------------------
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print(">>> row selected \(indexPath.description)")
    }

}

