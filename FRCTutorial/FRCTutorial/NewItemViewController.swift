//
//  NewItemViewController.swift
//  FRCTutorial
//
//  Created by Vojtech Kubat on 3/21/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import UIKit

class NewItemViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var labelMain: UILabel!


    @IBAction func cancel (sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func add (sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}