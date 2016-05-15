//
//  FilterViewController.swift
//  Bubble Tea Finder
//
//  Created by Pietro Rea on 8/27/14.
//  Copyright (c) 2014 Pietro Rea. All rights reserved.
//

import UIKit
import CoreData

protocol FilterViewControllerDelegate: class {
    func filterViewController(filter: FilterViewController, didSelectPredicate predicate:NSPredicate?, sortDescriptor:NSSortDescriptor?)
}

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
    
    weak var delegate: FilterViewControllerDelegate?
    var selectedSortDescriptor: NSSortDescriptor?
    var selectedPredicate: NSPredicate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePriceVenueCountLabel(1)
        populatePriceVenueCountLabel(2)
        populatePriceVenueCountLabel(3)
        populateDealsCountLabel()
//        populateCheapVenueCountLabel()
    }
    
    func pricePredicate (x: NSInteger) -> NSPredicate {
        var sign: NSString
        switch x {
        case 1:
            sign = "$"
        case 2:
            sign = "$$"
        default:
            sign = "$$$"
        }
        return NSPredicate(format: "priceInfo.priceCategory == %@", "\(sign)")
    }
    
    lazy var offeringDealPredicate = NSPredicate(format: "specialCount > 0")
    lazy var walingDistancePredicate = NSPredicate(format: "location.distance <= 500")
    lazy var hasUserTipsPredicate = NSPredicate(format: "stats.tipCount > 0")
    
    lazy var nameSortDescriptor = NSSortDescriptor(key: "name",
                                                   ascending: true,
                                                   selector: #selector(NSString.localizedStandardCompare(_:)))
    lazy var distanceSortDescriptor = NSSortDescriptor(key: "location.distance", ascending: true)
    lazy var priceSortDescriptor = NSSortDescriptor(key: "priceInfo.priceCategory", ascending: true)
    
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
            default:
                thirdPriceCategoryLabel.text = "\(count) bubble tea places"
            }
            
        } catch let error as NSError {
            print("Cannot execute fetch request: \(error)")
        }
    }
    
    func populateDealsCountLabel() {
        let fetchRequest = NSFetchRequest(entityName: "Venue")
        fetchRequest.resultType = .DictionaryResultType
        
        let sumExpressionDesc = NSExpressionDescription()
        
        // under this name (), the result will be accessible in the dictionary result
        sumExpressionDesc.name = "sumDeals"
        sumExpressionDesc.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "specialCount")])
        sumExpressionDesc.expressionResultType = .Integer32AttributeType
        fetchRequest.propertiesToFetch = [sumExpressionDesc]
        
        do {
            let results = try coreDataStack.context.executeFetchRequest(fetchRequest) as! [NSDictionary]
            let resultDict = results.first!
            let numDeals = resultDict["sumDeals"]
            numDealsLabel.text = "\(numDeals!) total deals"
        } catch let error as NSError {
            print("Cannot execute fetch: \(error)")
        }
    }

    //MARK - UITableViewDelegate methods

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        
        switch cell {
        case cheapVenueCell:
            selectedPredicate = pricePredicate(1)
            clearPredication()
        case moderateVenueCell:
            selectedPredicate = pricePredicate(2)
            clearPredication()
        case expensiveVenueCell:
            selectedPredicate = pricePredicate(3)
            clearPredication()
            
        case offeringDealCell:
            selectedPredicate = offeringDealPredicate
            clearPredication()
        case walkingDistanceCell:
            selectedPredicate = walingDistancePredicate
            clearPredication()
        case userTipsCell:
            selectedPredicate = hasUserTipsPredicate
            clearPredication()
            
        case nameAZSortCell:
            selectedSortDescriptor = nameSortDescriptor
            clearSorting()
        case nameZASortCell:
            selectedSortDescriptor = (nameSortDescriptor.reversedSortDescriptor as! NSSortDescriptor)
            clearSorting()
        case distanceSortCell:
            selectedSortDescriptor = distanceSortDescriptor
            clearSorting()
        case priceSortCell:
            selectedSortDescriptor = priceSortDescriptor
            clearSorting()
            
        default:
            NSLog("unknown cell")
        }
        
        cell.accessoryType = .Checkmark
    }
    
    func clearPredication() {
        cheapVenueCell.accessoryType = .None
        moderateVenueCell.accessoryType = .None
        expensiveVenueCell.accessoryType = .None
        offeringDealCell.accessoryType = .None
        walkingDistanceCell.accessoryType = .None
        userTipsCell.accessoryType = .None
    }
    
    func clearSorting() {
        nameAZSortCell.accessoryType = .None
        nameZASortCell.accessoryType = .None
        distanceSortCell.accessoryType = .None
        priceSortCell.accessoryType = .None
    }

    // MARK - UIButton target action

    @IBAction func saveButtonTapped(sender: UIBarButtonItem) {
        delegate?.filterViewController(self, didSelectPredicate: selectedPredicate, sortDescriptor: selectedSortDescriptor)
        dismissViewControllerAnimated(true, completion:nil)
    }
}
