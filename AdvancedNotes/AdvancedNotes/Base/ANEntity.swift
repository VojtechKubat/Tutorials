//
//  ANEntity.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 19/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import CoreData

class ANEntity: NSManagedObject {
    
    var getLastChange: NSDate! {
        get {
            preconditionFailure("This method must be overridden")
        }
    }
}