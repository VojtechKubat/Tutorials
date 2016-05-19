//
//  NSManagedObject+Utils.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 19/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    static func myNewEntity(context: NSManagedObjectContext) -> NSManagedObject? {
        let ed = NSEntityDescription.entityForName("\(self)", inManagedObjectContext: context)
        guard (ed != nil) else {return nil}
        return NSManagedObject(entity: ed!, insertIntoManagedObjectContext: context)
    }
}