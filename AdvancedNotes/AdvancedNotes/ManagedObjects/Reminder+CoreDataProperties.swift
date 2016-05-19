//
//  Reminder+CoreDataProperties.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 19/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Reminder {

    @NSManaged var active: NSNumber?
    @NSManaged var recurrence: String?
    @NSManaged var time: NSDate?
    @NSManaged var type: NSNumber?
    @NSManaged var id: NSNumber?
    @NSManaged var relatesToNote: Note?

}
