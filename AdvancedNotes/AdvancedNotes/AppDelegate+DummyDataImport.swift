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
                let jsonDict = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
                
                let tagsJson = jsonDict["tags"] as! NSArray
                for currentTag in tagsJson {
                    Tag.parseJsonToTag(currentTag as! NSDictionary, context: coreDataStack.context)
                }
                
                let notesJson = jsonDict["notes"] as! NSArray
                for _ in 0...1000 {
                    for currentNote in notesJson {
                        Note.parseJsonToNote(currentNote as! NSDictionary, context: coreDataStack.context)
                    }
                }
                print("Dummy data was inserted")
                
                CoreDataService.trySave(coreDataStack.context)
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