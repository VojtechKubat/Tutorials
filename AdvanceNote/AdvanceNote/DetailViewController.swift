//
//  ViewController.swift
//  AdvanceNote
//
//  Created by Vojtech Kubat on 06/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var headline = "Default headline"
    
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = headline
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

