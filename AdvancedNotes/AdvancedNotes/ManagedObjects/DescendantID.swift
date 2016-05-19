//
//  DescendantID.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 19/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import CoreData


class DescendantID: NSManagedObject {

    static func parseJsonToDescendantID(descID: Int, context: NSManagedObjectContext) -> DescendantID? {
        return DescendantID.parseJsonToDescendantID(descID, context: context, save: false)
    }
    
    static func parseJsonToDescendantID(descID: Int, context: NSManagedObjectContext, save: Bool) -> DescendantID? {
        let desc = myNewEntity(context) as! DescendantID
        desc.id = descID
        return desc
    }
}
