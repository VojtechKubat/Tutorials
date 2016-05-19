//
//  Paragraph.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 16/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import CoreData


class Paragraph: ANEntity {
    
    override var getLastChange: NSDate! {
        get {return self.lastChange ?? NSDate.distantFuture()}
    }
    
    static func parseJsonToParagraph(jsonDict: NSDictionary, context: NSManagedObjectContext) -> Paragraph? {
        return Paragraph.parseJsonToParagraph(jsonDict, context: context, save: false)
    }

    static func parseJsonToParagraph(jsonDict: NSDictionary, context: NSManagedObjectContext, save: Bool) -> Paragraph? {
        let paragraph = myNewEntity(context) as! Paragraph
        guard (jsonDict.count != 0) else {return nil}
        
        paragraph.id = NSNumber(integer: Int(jsonDict.valueForKey("id") as! String)!)
        paragraph.text = (jsonDict.valueForKey("text") as! String)
        paragraph.active = ((jsonDict.valueForKey("active") as! Int) == 1)
        paragraph.lastChange = NSDate.isoToDate(jsonDict.valueForKey("lastChange") as! String)
        
        if save {CoreDataService.trySave(context)}
        
        return paragraph
    }
}
