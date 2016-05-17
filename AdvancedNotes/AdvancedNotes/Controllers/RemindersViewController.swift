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
        
        
        let addReminder = UIBarButtonItem(barButtonSystemItem: .Add,
                                          target: self,
                                          action: #selector(RemindersViewController.addReminder))
        self.navigationItem.rightBarButtonItem = addReminder
        
//        self.tabBarController?.navigationItem.title = "it works!"
//        self.tabBarController?.navigationItem.rightBarButtonItem = addReminder
        
//        let closure = {[weak self]() in
//            self!.addReminder()
//        }
        
    }
    
    func addReminder() {
        
    }
    
    override var description: String {
        return ("\(super.description) - RemindersViewController")
    }
}