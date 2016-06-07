//
//  MasterViewController.swift
//  AdvanceNote
//
//  Created by Vojtech Kubat on 06/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MasterViewController: UITableViewController {
    
    var fetchedResultsController: NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest(entityName: "Note")
        fetchRequest.fetchBatchSize = 20
        let sortDescriptior = NSSortDescriptor(key: "lastChange", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptior]
        
        
        let privateContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        privateContext.parentContext = CoreDataService.sharedInstance.context
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: CoreDataService.sharedInstance.context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: "notesCache")
        
        fetchedResultsController.managedObjectContext.performBlock({() in
            do {
                try self.fetchedResultsController.performFetch()
            } catch let error as NSError {
                print("ERROR: \(error.userInfo)")
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        })
        
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (fetchedResultsController.sections == nil) {
            return 0
        }
        return fetchedResultsController.sections!.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (fetchedResultsController.sections == nil) {
            return 0
        }
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell")! as! MainTableViewCell
//        cell.configureCell("Hello - \(indexPath.row)")
        cell.configureCell((fetchedResultsController.sections![indexPath.section].objects![indexPath.row]) as! Note)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail",
                                        sender: (fetchedResultsController.sections![indexPath.section].objects![indexPath.row]) as! Note)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            (segue.destinationViewController as! DetailNavController).configureDetail(sender as! Note)
        }
    }
}