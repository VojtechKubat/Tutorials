//
//  Note+CoreDataProperties.swift
//  MRNotes
//
//  Created by Vojtech Kubat on 3/16/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Note {

    @NSManaged var date: NSDate?
    @NSManaged var title: String?
    @NSManaged var body: String?
    @NSManaged var keywords: String?

}
