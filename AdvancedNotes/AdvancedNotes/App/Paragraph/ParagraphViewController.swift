//
//  ParagraphViewController.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 17/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import UIKit

class ParagraphViewController: UIViewController {
    var paragraph: Paragraph?
    
    @IBOutlet weak var textView: FrameTextView!
    
    @IBAction func discardChanges(sender: UIBarButtonItem) {
        let dialogDiscard = UIAlertController(title: "Discard all changes?",
                                                    message: "",
                                                    preferredStyle: .Alert)
        
        let actionDiscard = UIAlertAction(title: "Discard changes", style: .Default , handler: {(action) in
            
        })
        dialogDiscard.addAction(actionDiscard)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .Default, handler: {(action) in
            
        })
        dialogDiscard.addAction(actionCancel)
        
        self.presentViewController(dialogDiscard, animated: false, completion: {})
    }
    
    override func viewDidLoad() {
        textView.text = paragraph?.text
    }
    
}