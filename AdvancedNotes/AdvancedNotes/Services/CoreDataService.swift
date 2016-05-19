//
//  CoreDataService.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 17/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import CoreData

class CoreDataService {
    static var sharedInstance = CoreDataStack()
    
    static func trySave(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Changes in context were saved")
        } catch let error as NSError {
            print("context save error - \(error) - \(error.userInfo)")
        }
    }
    
}