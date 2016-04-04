//
//  Bowtie.swift
//  Bow Ties
//
//  Created by Vojtech Kubat on 3/24/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Bowtie: NSManagedObject {

    func printInfo () {
        print("------------------")
        print("name: \(self.name!)")
        print("rating: \(self.rating!.doubleValue)/5")
        print("isFavorite: \(self.isFavorite!)")
        print("last worn: \(self.lastWorn!)")
        var red = CGFloat(), green = CGFloat(), blue = CGFloat(), alpha = CGFloat()
        
        (self.tintColor as! UIColor).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        print("color tint: \(red), \(green), \(blue)")
    }

    static func colorFromDict (source: NSDictionary) -> UIColor {
        let result = UIColor.blackColor()
        
        guard let red = source["red"] as? NSNumber,
            green = source["green"] as? NSNumber,
            blue = source["blue"] as? NSNumber
            else {return result}
        guard red.intValue >= 0 && red.intValue <= 255 &&
            green.intValue >= 0 && green.intValue <= 255 &&
            blue.intValue >= 0 && blue.intValue <= 255
            else {return result}
        return UIColor(red: CGFloat(red)/255.0,
                       green: CGFloat(green)/255.0,
                       blue: CGFloat(blue)/255.0,
                       alpha: 1)
    }
}
