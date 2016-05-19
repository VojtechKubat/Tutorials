//
//  Picture.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 16/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import CoreData

class Picture: ANEntity {

    override var getLastChange: NSDate! {
        get {return self.lastChange ?? NSDate.distantFuture()}
    }
 
    static func parseJsonToPicture(jsonDict: NSDictionary, context: NSManagedObjectContext) -> Picture? {
        return Picture.parseJsonToPicture(jsonDict, context: context, save: false)
    }
    
    static func parseJsonToPicture(jsonDict: NSDictionary, context: NSManagedObjectContext, save: Bool) -> Picture? {
        let picture = myNewEntity(context) as! Picture
        guard (jsonDict.count != 0) else {return nil}
        
        picture.id = NSNumber(integer: Int(jsonDict.valueForKey("id") as! String)!)
        picture.textDetail = (jsonDict.valueForKey("textDetail") as! String)
        picture.active = ((jsonDict.valueForKey("active") as! Int) == 1)
        picture.lastChange = NSDate.isoToDate(jsonDict.valueForKey("lastChange") as! String)
        
// TODO - this url works for dummy data only !!! - rewrite it for general use
        let pictureUrl = NSBundle.mainBundle().URLForResource((jsonDict.valueForKey("imageURL") as! String), withExtension: "jpg")
        
        if (pictureUrl != nil) {
            picture.image = Picture.dataForURLImage(pictureUrl!)
        } else {
            print("Picture was not found - \(picture.id) - \(jsonDict.valueForKey("imageURL"))")
        }
        
        if save {CoreDataService.trySave(context)}

        return picture
    }
    
    static func dataForURLImage(url: NSURL) -> NSData {
        let data = NSData()
        return data
    }
    
}
