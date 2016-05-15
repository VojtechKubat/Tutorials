//
//  SummaryViewController.swift
//  AdvanceNote
//
//  Created by Vojtech Kubat on 09/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import UIKit

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBAction func addAttachment(sender: UIButton) {
        let addAttachmentDialog = UIAlertController(title: "Add new attachment",
                                                    message: "What do you want to add to your note?",
                                                    preferredStyle: .ActionSheet)
        let addText = UIAlertAction(title: "Text note", style: .Default, handler: {(action) in
            
        })
        addAttachmentDialog.addAction(addText)
        let addImage = UIAlertAction(title: "Image", style: .Default, handler: {(action) in
            
        })
        addAttachmentDialog.addAction(addImage)
        self.presentViewController(addAttachmentDialog, animated: true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "hello"
    }

}