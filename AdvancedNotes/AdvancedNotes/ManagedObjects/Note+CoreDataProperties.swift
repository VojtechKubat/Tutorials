//
//  Note+CoreDataProperties.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 16/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Note {

    @NSManaged var active: NSNumber?
    @NSManaged var headline: String?
    @NSManaged var lastChange: NSDate?
    @NSManaged var priority: NSNumber?
    @NSManaged var hasChild: NSSet?
    @NSManaged var hasParagraph: NSSet?
    @NSManaged var hasParent: Note?
    @NSManaged var hasPicture: NSSet?
    @NSManaged var hasReminder: NSSet?
    @NSManaged var isTagged: NSSet?

}
