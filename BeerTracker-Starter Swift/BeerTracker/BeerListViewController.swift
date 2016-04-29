//
//  ViewController.swift
//  BeerTracker
//
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit
import Foundation

class BeerListViewController: UITableViewController {

  @IBOutlet weak var sortByControl: UISegmentedControl!
  @IBOutlet weak var searchBar: UISearchBar!
  
  let sortKeyName   = "name"
  let sortKeyRating = "beerDetails.rating"
  let wbSortKey     = "wbSortKey"

  //------------------------------------------
  // Rating
  
  var amRatingCtl: AnyObject!
  
  let beerEmptyImage: UIImage = UIImage(named: "beermug-empty")!
  let beerFullImage:  UIImage = UIImage(named: "beermug-full")!
  
  //#####################################################################
  // MARK: - Initialization
  
  required init(coder aDecoder: NSCoder) {
    // Automatically invoked by UIKit as it loads the view controller from the storyboard.
    
    amRatingCtl = AMRatingControl(location: CGPointMake(190, 10),
                                emptyImage: beerEmptyImage,
                                solidImage: beerFullImage,
                              andMaxRating: 5)    
    
    // A call to super is required after all variables and constants have been assigned values but before anything else is done.
    super.init(coder: aDecoder)!
  }
  //#####################################################################
  // MARK: - Segues
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Allows data to be passed to the new view controller before the new view is displayed.
    
    // "destinationViewController" must be cast from its generic type (AnyObject) to the specific type used in this app
    // (BeerDetailViewController) before any of its properties can be accessed.
    let controller = segue.destinationViewController as? BeerDetailViewController
    
    if segue.identifier == "editBeer" {

      controller!.navigationItem.rightBarButtonItems = []
      
    //------------------------------------------------------------------------------------
    } else if segue.identifier == "addBeer" {
        controller?.addButtons()
    }
  }
  //#####################################################################
  // MARK: - UIViewController - Responding to View Events
  
  override func viewWillAppear(animated: Bool) {
    
    super.viewWillAppear(animated)
    
    //------------------------------------------
    // Sorting Key
    
    if !(NSUserDefaults.standardUserDefaults().objectForKey(wbSortKey) != nil) {
      // User's sort preference has not been saved.  Set default to sort by rating.
      NSUserDefaults.standardUserDefaults().setObject(sortKeyRating, forKey: wbSortKey)
    }
    
    // Keep the sort control in the UI in sync with the means by which the list is sorted.
    if NSUserDefaults.standardUserDefaults().objectForKey(wbSortKey) as! String == sortKeyName {
      sortByControl.selectedSegmentIndex = 1
    }
    //------------------------------------------
    fetchAllBeers()
    
    // Cause tableView(cellForRowAtIndexPath) to be called again for every visible row in order to update the table.
    tableView.reloadData()
  }
  //#####################################################################
  // MARK: - UIViewController - Managing the View
  
  // viewDidLoad() is called after prepareForSegue().
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    //------------------------------------------
    
    tableView.contentOffset = CGPointMake(0, 44)
  }
  //#####################################################################
  // MARK: - Action Methods
  
  @IBAction func sortByControlChanged(sender: UISegmentedControl) {
    
    switch sender.selectedSegmentIndex {
      
    case 0:
      NSUserDefaults.standardUserDefaults().setObject(sortKeyRating, forKey: wbSortKey)
      fetchAllBeers()
      tableView.reloadData()

    case 1:
      NSUserDefaults.standardUserDefaults().setObject(sortKeyName, forKey: wbSortKey)
      fetchAllBeers()
      tableView.reloadData()

    default:
      break
    }
  }
  //#####################################################################
  // MARK: - MagicalRecord Methods
  
  func fetchAllBeers() {
  }
  //#####################################################################
  
  func saveContext() {
  }
  //#####################################################################
}

//#####################################################################
// MARK: - Table View Data Source

extension BeerListViewController {
  
  //#####################################################################
  // MARK: Configuring a Table View
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  //#####################################################################

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  //#####################################################################

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
    
    configureCell(cell, atIndex: indexPath)
    
    return cell
  }
  //#####################################################################
  // MARK: Helper Methods
  
  func configureCell(cell: UITableViewCell, atIndex indexPath: NSIndexPath) {

    //------------------------------------------
    // Rating
    
    let ratingText = ""
    
    let myRect = CGRect(x:250, y:0, width:200, height:50)
    var ratingLabel = UILabel(frame: myRect)
    
    if !(cell.viewWithTag(20) != nil) {
      
      ratingLabel.tag = 20
      ratingLabel.text = ratingText
      cell.addSubview(ratingLabel)
      
    } else {
      ratingLabel = cell.viewWithTag(20) as! UILabel
    }
    //----------------------
    ratingLabel.text = ratingText
    
  }
  //#####################################################################
  // MARK: Inserting or Deleting Table Rows
  
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  //#####################################################################
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    // When the commitEditingStyle method is present in a view controller, the table view will automatically enable swipe-to-delete.
    
    if (editingStyle == .Delete) {
      
    }
  }
  //#####################################################################
}
//#####################################################################
// MARK: - Search Bar Delegate

extension BeerListViewController: UISearchBarDelegate {
  
  // MARK: Editing Text
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    
    if searchBar.text != "" {
      performSearch()
      
    } else {
      fetchAllBeers()
      tableView.reloadData()
    }
  }
  //#####################################################################
  
  func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
  }
  //#####################################################################
  // MARK: Clicking Buttons
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    
    searchBar.resignFirstResponder()
    searchBar.text = ""
    searchBar.showsCancelButton = false
    fetchAllBeers()
    tableView.reloadData()
  }
  //#####################################################################

  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    // This method is invoked when the user taps the Search button on the keyboard.
    
    searchBar.resignFirstResponder()
    performSearch()
  }
  //#####################################################################
  // MARK: Helper Methods
  
  func performSearch() {
    tableView.reloadData()
  }
  //#####################################################################
  // MARK: - Bar Positioning Delegate
  //         UISearchBarDelegate Protocol extends UIBarPositioningDelegate protocol.
  //         Method positionForBar is part of the UIBarPositioningDelegate protocol.
  
  // This delegate method is required to prevent a gap between the top of the screen and the search bar.
  // That happens because, as of iOS 7, the status bar is no longer a separate area but is directly drawn on top of the view controller.
  
  func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
    // Tell the search bar to extend under the status bar area.
    
    return .TopAttached
  }
  //#####################################################################
}

