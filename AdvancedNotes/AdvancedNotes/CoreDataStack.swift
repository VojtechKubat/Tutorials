//
//  CoreDataStack.swift
//  AdvanceNote
//
//  Created by Vojtech Kubat on 13/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    let modelName = "AdvancedNotesModel"
    
    // document directory - there are stored the mysql file, that contains all of the records
    private lazy var applicationDocumentDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    // NSManagedObjectModel - data model loaded from app bundle
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")
        // if the data model was not found, application cannot work and will be aborted
        guard (modelURL != nil) else {
            NSLog("ERROR - Data model was not found within application bundle")
            abort()
        }
        return NSManagedObjectModel(contentsOfURL: modelURL!)!
    }()
    
    // NSPersistantStoreCoordinator is the link between data model and persistent store
    private lazy var psc: NSPersistentStoreCoordinator = {
        let coordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentDirectory.URLByAppendingPathComponent(self.modelName)
        
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption: true]
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
        } catch let error as NSError {
            NSLog("ERROR - persistant store coordinator cannot be linked to persistant store")
            NSLog("\(error.description)")
        }
        return coordinator
    }()
    
    lazy var context: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.psc
        return managedObjectContext
    }()
    
    func  saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                NSLog("ERROR: \(error.description)")
            }
        }
    }
}