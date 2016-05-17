//
//  AppDelegate+DummyDataImport.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 17/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import CoreData

extension AppDelegate {
    func importDummyData() {
        let request = NSFetchRequest(entityName: "Note")
        var results = [AnyObject]()
        
        do {
            results = try coreDataStack.context.executeFetchRequest(request)
        } catch let error as NSError {
            print("ERROR - fetch request failed - \(error.userInfo)")
        }
        
        if (results.count == 0) {
            let jsonURL = NSBundle.mainBundle().URLForResource("AdvancedNotesSeed", withExtension: "json")
            let jsonData = NSData(contentsOfURL: jsonURL!)
            
            do {
                guard (jsonData != nil) else {return}
                let jsonDict = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
                
                // for easier access, an array is created for tags
                var tags = Dictionary<Int, Tag>()
                let tagsJson = jsonDict["tags"] as! NSArray
                
                for current in tagsJson {
                    let tagED = NSEntityDescription.entityForName("Tag", inManagedObjectContext: coreDataStack.context)!
                    let tag = Tag(entity: tagED, insertIntoManagedObjectContext: coreDataStack.context)
                    tag.label = (current.valueForKey("label") as! String)
                    
                    tags[current.valueForKey("tagId") as! Int] = tag
                }
                
                // parsing notes and all attachements
                let noteED = NSEntityDescription.entityForName("Note", inManagedObjectContext: coreDataStack.context)!
                let paragraphED = NSEntityDescription.entityForName("Paragraph", inManagedObjectContext: coreDataStack.context)!
                let pictureED = NSEntityDescription.entityForName("Picture", inManagedObjectContext: coreDataStack.context)!
                let reminderED = NSEntityDescription.entityForName("Reminder", inManagedObjectContext: coreDataStack.context)!
                
                let notesJson = jsonDict["notes"] as! NSArray
                for currentNote in notesJson {
                    var lastChange = NSDate.distantPast()
                    let note = Note(entity: noteED, insertIntoManagedObjectContext: coreDataStack.context)
                    
                    note.active = (currentNote.valueForKey("active") as! Int) == 1
                    note.priority = currentNote.valueForKey("priority") as! Int
                    
                    var paragraphs = Set<Paragraph>()
                    for currentParagraph in (currentNote.valueForKey("paragraphs") as! NSArray) {
                        let paragraph = Paragraph(entity: paragraphED, insertIntoManagedObjectContext: coreDataStack.context)
                        paragraph.active = (currentParagraph.valueForKey("active") as! Int) == 1
                        paragraph.text = (currentParagraph.valueForKey("text") as! String)
                        paragraph.lastChange = NSDate.isoToDate(currentParagraph.valueForKey("lastChange") as! String)
                        
                        if (paragraph.lastChange?.compare(lastChange) == NSComparisonResult.OrderedDescending) {
                            lastChange = paragraph.lastChange!
                        }
                        
                        paragraphs.insert(paragraph)
                    }
                    note.hasParagraph = paragraphs
                    
                    var pictures = Set<Picture>()
                    for currentPicture in (currentNote.valueForKey("pictures") as! NSArray) {
                        let picture = Picture(entity: pictureED, insertIntoManagedObjectContext: coreDataStack.context)
                        
                        let pictureUrl = NSBundle.mainBundle().URLForResource((currentPicture.valueForKey("imageURL") as! String), withExtension: "jpg")
                        let pictureData = NSData.init(contentsOfURL: pictureUrl!)
                        picture.image = pictureData
                        
                        picture.active = (currentPicture.valueForKey("active") as! Int) == 1
                        picture.textDetail = (currentPicture.valueForKey("textDetail") as! String)
                        picture.lastChange = NSDate.isoToDate(currentPicture.valueForKey("lastChange") as! String)
                        
                        if (picture.lastChange?.compare(lastChange) == NSComparisonResult.OrderedDescending) {
                            lastChange = picture.lastChange!
                        }
                        
                        pictures.insert(picture)
                    }
                    note.hasPicture = pictures
                    
                    var reminders = Set<Reminder>()
                    for currentReminder in (currentNote.valueForKey("reminders") as! NSArray) {
                        let reminder = Reminder(entity: reminderED, insertIntoManagedObjectContext: coreDataStack.context)
                        reminder.type = (currentReminder.valueForKey("type") as! NSNumber)
                        reminder.active = (currentReminder.valueForKey("active") as! Int) == 1
                        reminder.time = NSDate.isoToDate(currentReminder.valueForKey("time") as! String)
                        
                        reminders.insert(reminder)
                    }
                    note.hasReminder = reminders
                    
                    var tagsOfNote = Set<Tag>()
                    for currentTag in (currentNote.valueForKey("tags") as! NSArray) {
                        tagsOfNote.insert(tags[(currentTag as! Int)]!)
                    }
                    note.isTagged = tagsOfNote
                    note.lastChange = lastChange
                    note.headline = (currentNote.valueForKey("headline") as! String)
                }
                
                try coreDataStack.context.save()
                print("Dummy data was inserted")
            } catch let error as NSError {
                print("ERROR - \(error.userInfo)")
            }
        } else {
            print("There are \(results.count) notes")
            print("No dummy data was inserted")
            
            for currentNote in results {
                print("\((currentNote as! Note).headline) \((currentNote as! Note).lastChange)")
            }
        }
    }
}