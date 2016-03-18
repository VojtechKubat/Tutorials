//
//  Game.swift
//  DungeonGame
//
//  Created by Vojtech Kubat on 3/18/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Game {
    static let sharedInstance = Game()
    var coreDataStack = (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStack
    
// MARK: Dummy core data operations
    func fillInDummyData () {
        listAllNPCs()
        deleteNPCOnIndex(1)
        listAllNPCs()
    }
    
    func listAllNPCs () {
        var results = [AnyObject]()
        let fetchRequest = NSFetchRequest()
        let entityDescriptionRequest = NSEntityDescription.entityForName("NPC", inManagedObjectContext: coreDataStack.managedObjectContext)
        fetchRequest.entity = entityDescriptionRequest
        
        do {
            results = try coreDataStack.managedObjectContext.executeFetchRequest(fetchRequest)
        } catch {
            print(error)
        }
        
        for current in results {
            print(">>> NPC name: \(current.valueForKey("name")!) ; level: \(current.valueForKey("level")) ; bio: \(current.valueForKey("bio")!)")
        }
    }
    
    func deleteNPCOnIndex (index: Int) {
        var results = [AnyObject]()
        let fetchRequest = NSFetchRequest()
        let entityDescriptionRequest = NSEntityDescription.entityForName("NPC", inManagedObjectContext: coreDataStack.managedObjectContext)
        fetchRequest.entity = entityDescriptionRequest
        
        do {
            results = try coreDataStack.managedObjectContext.executeFetchRequest(fetchRequest)
        } catch {
            print(error)
        }
        
        if (results.count > index) {
            coreDataStack.managedObjectContext.deleteObject(results[index] as! NSManagedObject)
            do {
                try coreDataStack.managedObjectContext.save()
            } catch {
                print(error)
            }
        }
        print("total: \(results.count)")
        print("------------------------------------------------------------")
    }
}