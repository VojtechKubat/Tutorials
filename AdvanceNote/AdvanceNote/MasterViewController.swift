//
//  MasterViewController.swift
//  AdvanceNote
//
//  Created by Vojtech Kubat on 06/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import UIKit

class MasterViewController: UITableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell")! as! MainTableViewCell
        cell.configureCell("Hello - \(indexPath.row)")
        cell.leftHeading.constant = CGFloat(10*indexPath.row)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            print(">>> a cell was tapped  \"\((sender as! MainTableViewCell).headlineLabel.text!)\"")
            
            
            
            
            (segue.destinationViewController as! DetailViewController).headline = (sender as! MainTableViewCell).headlineLabel.text!
        }
    }
}