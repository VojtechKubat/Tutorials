//
//  Tag.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 16/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import CoreData


class Tag: NSManagedObject {

    static func parseJsonToTag(jsonDict: NSDictionary, context: NSManagedObjectContext) -> Tag? {
        return Tag.parseJsonToTag(jsonDict, context: context, save: false)
    }
    
    static func parseJsonToTag(jsonDict: NSDictionary, context: NSManagedObjectContext, save: Bool) -> Tag? {
        let tag = myNewEntity(context) as! Tag
        guard (jsonDict.count != 0) else {return nil}
        
        tag.id = NSNumber(integer: jsonDict.valueForKey("id") as! Int)
        tag.label = (jsonDict.valueForKey("label") as! String)
        
        if save {CoreDataService.trySave(context)}
        
        return tag
    }
}
