//
//  RemindersViewController.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 13/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import UIKit

class RemindersViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.splitViewController?.navigationController?.topViewController?.title = "Hello"
    }
}