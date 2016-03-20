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
//        listAllNPCs()
        for i in 0...10 {
            addDummyNPC(i)
            addDummyModifiers(i)
        }
        listAllNPCs()
        listAllModifiers()
        addDummyComplex(2)
//        deleteNPCOnIndex(1)
//        listAllNPCs()
        listAllNPCs()
        
    }
    
    func addDummyComplex (seed: Int) {
        let npcED = NSEntityDescription.entityForName("NPC", inManagedObjectContext: coreDataStack.managedObjectContext)
//        let predicate = NSPredicate(format: "%K == %@", "name", "John")
        
        let key = "name"
        let value = "John"
        let predicate = NSPredicate(format: "\(key) == \"\(value)\"")
        
        let theNPC = NSFetchRequest()
    
        theNPC.entity = npcED
        theNPC.predicate = predicate
        
        var resultNPC = [AnyObject]()
        
        do {
            resultNPC = try coreDataStack.managedObjectContext.executeFetchRequest(theNPC)
        } catch {
            print(error)
        }
        
        print("-----------------")
        print(">>> looking for NPC John")
        print(">>> predicate: \(predicate.description)")
        print(">>> total NPC results: \(resultNPC.count)")
        
        for current in resultNPC {
            print("-----------------")
            print(">>> NPC name: \(current.valueForKey("name")!)")
            print(">>> level: \(current.valueForKey("level")!)")
            print(">>> bio: \(current.valueForKey("bio")!)")
            print(">>> modifiers count: \(current.valueForKey("influencedBy")?.count)")
        }
        print("-----------------")
        
        
        let theModifiers = NSFetchRequest()
        let modifierED = NSEntityDescription.entityForName("Modifier", inManagedObjectContext: coreDataStack.managedObjectContext)
        let modifPredicate = NSPredicate(format: "name == \"permanent boost\" OR name == \"penalty\"")

        theModifiers.entity = modifierED
        theModifiers.predicate = modifPredicate
        
        var resultModifiers = [AnyObject]()
        
        do {
            resultModifiers = try coreDataStack.managedObjectContext.executeFetchRequest(theModifiers)
        } catch {
            print(error)
        }

        print("-----------------")
        print(">>> looking for some modifiers")
        print(">>> predicate: \(modifPredicate.description)")
        print(">>> total modifiers results: \(resultNPC.count)")
        print("-----------------")
        for current in resultModifiers {
            print("-----------------")
            let modifier = current as! NSManagedObject
            print(">>> name: \(modifier.valueForKey("name")!)")
            print(">>> multiplier: \(modifier.valueForKey("multiplier")!)")
            print(">>> duration: \(modifier.valueForKey("duration")!)")
        }
        print("-----------------")
        
        (resultNPC.last as! NSManagedObject).setValue(NSSet(array: resultModifiers), forKey: "influencedBy")
        do {
            try resultNPC.last?.managedObjectContext.save()
        } catch {
            print(error)
        }
        
    }
    
    func addDummyNPC (seed: Int) {
        let npcED = NSEntityDescription.entityForName("NPC", inManagedObjectContext: coreDataStack.managedObjectContext)
        
        let allNpcs = NSFetchRequest()
        allNpcs.entity = npcED
        var results = [AnyObject]()
        
        do {
            results = try coreDataStack.managedObjectContext.executeFetchRequest(allNpcs)
        } catch {
            print(error)
        }
        
        if (!(results.count >= 10)) {
            let dummyNPC = NSManagedObject(entity: npcED!, insertIntoManagedObjectContext: coreDataStack.managedObjectContext)
            
            switch (seed) {
            case 0:
                dummyNPC.setValue("Bob", forKey: "name")
                dummyNPC.setValue("Something, something.", forKey: "bio")
                dummyNPC.setValue(1, forKey: "level")

            case 1:
                dummyNPC.setValue("Alice", forKey: "name")
                dummyNPC.setValue("Bla bla bla bla", forKey: "bio")
                dummyNPC.setValue(3, forKey: "level")

            case 2:
                dummyNPC.setValue("Edward", forKey: "name")
                dummyNPC.setValue("Another useless NPC.", forKey: "bio")
                dummyNPC.setValue(8, forKey: "level")

            case 3:
                dummyNPC.setValue("Jane", forKey: "name")
                dummyNPC.setValue("Bla bla something something. Nothing usefull.", forKey: "bio")
                dummyNPC.setValue(4, forKey: "level")

            case 4:
                dummyNPC.setValue("John", forKey: "name")
                dummyNPC.setValue("The most important character in the world!", forKey: "bio")
                dummyNPC.setValue(21, forKey: "level")
                
            case 5:
                dummyNPC.setValue("Paul", forKey: "name")
                dummyNPC.setValue("You don't want to met this guy, trust me.", forKey: "bio")
                dummyNPC.setValue(14, forKey: "level")
                
            default:
                dummyNPC.setValue("Dummy\(seed+1)", forKey: "name")
                dummyNPC.setValue(seed, forKey: "level")
                dummyNPC.setValue("Bla bla bla \(seed * 3)", forKey: "bio")
            }
            
            do {
                try dummyNPC.managedObjectContext?.save()
            } catch {
                print(error)
            }
        }
    }
    
    func addDummyModifiers (seed: Int) {
        let modifierED = NSEntityDescription.entityForName("Modifier", inManagedObjectContext: coreDataStack.managedObjectContext)
        let allModifiers = NSFetchRequest()
        allModifiers.entity = modifierED
        
        var results = [AnyObject]()
        
        do {
            results = try coreDataStack.managedObjectContext.executeFetchRequest(allModifiers)
        } catch {
            print(error)
        }
        
        
        if (results.count < 5) {
            let newModifier = NSManagedObject(entity: modifierED!, insertIntoManagedObjectContext: coreDataStack.managedObjectContext)
            
            switch seed {
            case 0:
                newModifier.setValue("boost", forKey: "name")
                newModifier.setValue(1.2, forKey: "multiplier")
                newModifier.setValue(30, forKey: "duration")
                newModifier.setValue("Small boost of", forKey: "desc")
            case 1:
                newModifier.setValue("penalty", forKey: "name")
                newModifier.setValue(0.8, forKey: "multiplier")
                newModifier.setValue(30, forKey: "duration")
                newModifier.setValue("Small penalty of", forKey: "desc")
            case 2:
                newModifier.setValue("permanent boost", forKey: "name")
                newModifier.setValue(1.2, forKey: "multiplier")
                newModifier.setValue(0, forKey: "duration")
                newModifier.setValue("permanent boost of", forKey: "desc")
            case 3:
                newModifier.setValue("permanent boost", forKey: "name")
                newModifier.setValue(1.2, forKey: "multiplier")
                newModifier.setValue(0, forKey: "duration")
                newModifier.setValue("permanent boost of", forKey: "desc")
            case 4:
                newModifier.setValue("permanent penalty", forKey: "name")
                newModifier.setValue(0.8, forKey: "multiplier")
                newModifier.setValue(0, forKey: "duration")
                newModifier.setValue("permanent penalty of", forKey: "desc")
            default:
                newModifier.setValue("small boost", forKey: "name")
                newModifier.setValue(1.2, forKey: "multiplier")
                newModifier.setValue(30, forKey: "duration")
                newModifier.setValue("Small boost of", forKey: "desc")
            }
            
            do {
                try newModifier.managedObjectContext?.save()
            } catch {
                print(error)
            }
        }
        
    }
    
    func listAllNPCs () {
        var results = [AnyObject]()
        let fetchRequest = NSFetchRequest()
        
        // get desired NSEntityDescription from managedObjectContext
        let entityDescriptionRequest = NSEntityDescription.entityForName("NPC", inManagedObjectContext: coreDataStack.managedObjectContext)
        // use the entity description for new request
        fetchRequest.entity = entityDescriptionRequest
        
        // execute the request
        do {
            results = try coreDataStack.managedObjectContext.executeFetchRequest(fetchRequest)
        } catch {
            print(error)
        }
        print(">>> All NPCs")
        // process the results
        for current in results {
            print("-----------------")
            print(">>> NPC name: \(current.valueForKey("name")!)")
            print(">>> level: \(current.valueForKey("level")!)")
            print(">>> bio: \(current.valueForKey("bio")!)")
            print(">>> modifiers count: \(current.valueForKey("influencedBy")?.count)")
        }
        print("-----------------")
    }
    
    func listAllModifiers () {
        var results = [AnyObject]()
        let modifiersED = NSEntityDescription.entityForName("Modifier", inManagedObjectContext: coreDataStack.managedObjectContext)
        let allModifiers = NSFetchRequest()
        allModifiers.entity = modifiersED
        
        do {
            results = try coreDataStack.managedObjectContext.executeFetchRequest(allModifiers)
        } catch {
            print(error)
        }
        
        print(">>> All modifiers")
        for current in results {
            print("-----------------")
            if current is NSManagedObject {
                let modifier = current as! NSManagedObject
                print(">>> name: \(modifier.valueForKey("name")!)")
                print(">>> multiplier: \(modifier.valueForKey("multiplier")!)")
                print(">>> duration: \(modifier.valueForKey("duration")!)")
            }
        }
        print("-----------------")
    }
    
    func deleteNPCOnIndex (index: Int) {
        var results = [AnyObject]()
        let fetchRequest = NSFetchRequest()
        
        // get desired NSEntityDescription from managedObjectContext
        let entityDescriptionRequest = NSEntityDescription.entityForName("NPC", inManagedObjectContext: coreDataStack.managedObjectContext)
        // use the entity description for new request
        fetchRequest.entity = entityDescriptionRequest
        
        // execute the request
        do {
            results = try coreDataStack.managedObjectContext.executeFetchRequest(fetchRequest)
        } catch {
            print(error)
        }
        
        if (results.count > index) {
            
            // call managedObjectContext with request to delte a particular NSManagedObject
            coreDataStack.managedObjectContext.deleteObject(results[index] as! NSManagedObject)
            
            // commit the delete operation by calling save on managedObjectContext
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