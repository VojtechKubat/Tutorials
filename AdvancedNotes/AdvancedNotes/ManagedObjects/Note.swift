//
//  Note.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 16/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import CoreData


class Note: ANEntity {
    
    override var getLastChange: NSDate! {
        get {return self.lastChange ?? NSDate.distantFuture()}
    }
    
    static func parseJsonToNote(jsonDict: NSDictionary, context: NSManagedObjectContext) -> Note? {
        return Note.parseJsonToNote(jsonDict, context: context, save: false)
    }

    static func parseJsonToNote(jsonDict: NSDictionary, context: NSManagedObjectContext, save: Bool) -> Note? {
        let note = myNewEntity(context) as! Note
        guard (jsonDict.count != 0) else {return nil}
        
        note.id = NSNumber(integer: Int(jsonDict.valueForKey("id") as! String)!)
        note.headline = (jsonDict.valueForKey("headline") as! String)
        note.priority = jsonDict.valueForKey("priority") as! Int
        note.active = ((jsonDict.valueForKey("active") as! Int) == 1)
        
        let paragraphs = NSMutableSet()
        for currentParagraph in (jsonDict.objectForKey("paragraphs") as! NSArray) {
            if let paragraph = Paragraph.parseJsonToParagraph(currentParagraph as! NSDictionary, context: context) {
                paragraphs.addObject(paragraph)
            }
        }
        note.hasParagraph = paragraphs
        
        let pictures = NSMutableSet()
        for currentPicture in (jsonDict.objectForKey("pictures") as! NSArray) {
            if let picture = Picture.parseJsonToPicture(currentPicture as! NSDictionary, context: context) {
                pictures.addObject(picture)
            }
        }
        note.hasPicture = pictures
        
        let reminders = NSMutableSet()
        for currentReminder in (jsonDict.objectForKey("reminders") as! NSArray) {
            if let reminder = Reminder.parseJsonToReminder(currentReminder as! NSDictionary, context: context) {
                reminders.addObject(reminder)
            }
        }
        note.hasReminder = reminders
        
        let descendants = NSMutableSet()
        for currentDesc in (jsonDict.objectForKey("descendants") as! NSArray) {
            if (currentDesc as? Int) != nil {
                descendants.addObject(currentDesc)
            }
        }
        note.hasDescendantID = descendants
        
        let request = NSFetchRequest(entityName: "Tag")
        var results = [AnyObject]()
        let tags = NSMutableSet()
        for currentTag in (jsonDict.objectForKey("tags") as! NSArray) {
            if (currentTag as? Int) != nil {
                request.predicate = NSPredicate(format: "id == \(currentTag)")
                do {
                    results = try context.executeFetchRequest(request)
                } catch let error as NSError {
                    print("ERROR - fetch request failed - \(error.userInfo)")
                }
                if (results.count == 1) {
                    tags.setByAddingObjectsFromArray(results)
                }
            }
        }
        
        if save {CoreDataService.trySave(context)}
        return note
    }

}
