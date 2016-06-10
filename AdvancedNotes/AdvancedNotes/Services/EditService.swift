//
//  EditService.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 08/06/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation

class EditService {
    static let sharedInstance = EditService()
    
    var note: Note?
    var currentEntity: ANEntity?
    
    func saveEntityChanges() {
      
        if (currentEntity != nil) {
            
            CoreDataService.sharedInstance.saveContext()
            
            print("save context")
            
            // if observer has no designated queue, then the thread of calling event will be used (can be useful for UI updates, so main thread is used)
            dispatch_async(dispatch_get_main_queue(), {
                NSNotificationCenter.defaultCenter().postNotificationName(changesPerformedKey, object: nil)
            })
        }
    }
    
    func isClass(theClass: AnyClass) -> Bool {
        if (currentEntity == nil) {
            return false
        }
        
        if (currentEntity!.isKindOfClass(theClass)) {
            return true
        }
        
        return false
    }
}