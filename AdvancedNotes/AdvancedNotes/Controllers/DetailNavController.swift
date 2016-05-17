//
//  ViewController.swift
//  AdvanceNote
//
//  Created by Vojtech Kubat on 06/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import UIKit

class DetailNavController: UINavigationController {

    var headline = "Default headline"
    
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureDetail(note: Note) {
        // get the top viewcontroller and set 
        self.visibleViewController?.title = note.headline
        print("\(self.visibleViewController?.description)")
    }
    
    override var description: String {
        return ("\(super.description) - DetailNavController")
    }

}