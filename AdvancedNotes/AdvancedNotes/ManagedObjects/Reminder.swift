//
//  Reminder.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 16/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import CoreData


class Reminder: ANEntity {
    
    override var getLastChange: NSDate! {
        get {return NSDate.distantFuture()}
    }

    static func parseJsonToReminder(jsonDict: NSDictionary, context: NSManagedObjectContext) -> Reminder? {
        return Reminder.parseJsonToReminder(jsonDict, context: context, save: false)
    }
    
    static func parseJsonToReminder(jsonDict: NSDictionary, context: NSManagedObjectContext, save: Bool) -> Reminder? {
        let reminder = myNewEntity(context) as! Reminder
        guard (jsonDict.count != 0) else {return nil}
        
        reminder.id = NSNumber(integer: Int(jsonDict.valueForKey("id") as! String)!)
        reminder.active = ((jsonDict.valueForKey("active") as! Int) == 1)
        reminder.time = NSDate.isoToDate(jsonDict.valueForKey("time") as! String)
        
        if save {CoreDataService.trySave(context)}
        
        return reminder
    }

}
