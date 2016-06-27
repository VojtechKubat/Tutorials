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