//
//  ViewController.swift
//  CoreDataTutorial
//
//  Created by Vojtech Kubat on 3/8/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var names = [String]()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.automaticallyAdjustsScrollViewInsets = false
        title = "\"The List\""
//        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addName(sender: AnyObject) {
        let alert = UIAlertController(title: "Add new name",
            message: "Type in a new name, you want to add.",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default,
            handler: {(action: UIAlertAction) -> Void in
                let textField = alert.textFields!.first
                self.names.append(textField!.text!)
//                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
//                })
            }
        )
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default,
            handler: {(alert: UIAlertAction) -> Void in
                
            }
        )

        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        alert.view.setNeedsLayout()
        
        presentViewController(alert,
            animated: true,
            completion: nil)
        
    }

// ---------------------------------------------------------
// MARK: UITableViewDataSource
// ---------------------------------------------------------
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell")
        cell?.textLabel?.text = names[indexPath.row]
        
        return cell!
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 90.0
//    }
    
// ---------------------------------------------------------
// MARK: UITableViewDelegate
// ---------------------------------------------------------
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print(">>> row selected \(indexPath.description)")
    }

}

