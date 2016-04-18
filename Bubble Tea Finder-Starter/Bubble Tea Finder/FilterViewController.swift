//
//  FilterViewController.swift
//  Bubble Tea Finder
//
//  Created by Pietro Rea on 8/27/14.
//  Copyright (c) 2014 Pietro Rea. All rights reserved.
//

import UIKit
import CoreData

class FilterViewController: UITableViewController {
  
    @IBOutlet weak var firstPriceCategoryLabel: UILabel!
    @IBOutlet weak var secondPriceCategoryLabel: UILabel!
    @IBOutlet weak var thirdPriceCategoryLabel: UILabel!
    @IBOutlet weak var numDealsLabel: UILabel!

    //Price section
    @IBOutlet weak var cheapVenueCell: UITableViewCell!
    @IBOutlet weak var moderateVenueCell: UITableViewCell!
    @IBOutlet weak var expensiveVenueCell: UITableViewCell!

    //Most popular section
    @IBOutlet weak var offeringDealCell: UITableViewCell!
    @IBOutlet weak var walkingDistanceCell: UITableViewCell!
    @IBOutlet weak var userTipsCell: UITableViewCell!

    //Sort section
    @IBOutlet weak var nameAZSortCell: UITableViewCell!
    @IBOutlet weak var nameZASortCell: UITableViewCell!
    @IBOutlet weak var distanceSortCell: UITableViewCell!
    @IBOutlet weak var priceSortCell: UITableViewCell!

    var coreDataStack: CoreDataStack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePriceVenueCountLabel(1)
        populatePriceVenueCountLabel(2)
        populatePriceVenueCountLabel(3)
        populateDealsCountLabel()
//        populateCheapVenueCountLabel()
    }
    
    lazy var cheapVenuePredicate: NSPredicate = {
        var predicate = NSPredicate(format: "priceInfo.priceCategory == %@", "$")
        return predicate
    }()
    
    func pricePredicate (x: NSInteger) -> NSPredicate {
        var sign: NSString
        switch x {
        case 1:
            sign = "$"
        case 2:
            sign = "$$"
        case 3:
            sign = "$$$"
        default:
            sign = "$"
        }
        return NSPredicate(format: "priceInfo.priceCategory == %@", "\(sign)")
    }
    
    func populatePriceVenueCountLabel(x: NSInteger) {
        let fetchRequest =  NSFetchRequest(entityName: "Venue")
        fetchRequest.resultType = .CountResultType
        fetchRequest.predicate = pricePredicate(x)
        
        do {
            let results = try coreDataStack.context.executeFetchRequest(fetchRequest) as! [NSNumber]
            let count = results.first!.integerValue
            
            switch x {
            case 1:
                firstPriceCategoryLabel.text = "\(count) bubble tea places"
            case 2:
                secondPriceCategoryLabel.text = "\(count) bubble tea places"
            case 3:
                thirdPriceCategoryLabel.text = "\(count) bubble tea places"
            default:
                firstPriceCategoryLabel.text = "\(count) bubble tea places"
            }
            
        } catch let error as NSError {
            print("Cannot execute fetch request: \(error)")
        }
    }
    
    func populateDealsCountLabel() {
        let fetchRequest = NSFetchRequest(entityName: "Veneue")
        fetchRequest.resultType = .DictionaryResultType
        
        let sumExpressionDesc = NSExpressionDescription()
        
        // under this name (), the result will be accessible in the dictionary result
        sumExpressionDesc.name = "sumDeals"
        sumExpressionDesc.expression = NSExpression(forFunction: "sum", arguments: [NSExpression(forKeyPath: "specialCount")])
        sumExpressionDesc.expressionResultType = .Integer32AttributeType
        fetchRequest.propertiesToFetch = [sumExpressionDesc]
        
        do {
            let results = try coreDataStack.context.executeFetchRequest(fetchRequest) as! [NSDictionary]
            let resultDict = results.first!
            let numDeals = resultDict["sumDeals"]
            numDealsLabel.text = "\(numDeals) total deals"
        } catch let error as NSError {
            print("Cannot execute fetch: \(error)")
        }
    }

    //MARK - UITableViewDelegate methods

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }

    // MARK - UIButton target action

    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {

        dismissViewControllerAnimated(true, completion:nil)
    }
}
