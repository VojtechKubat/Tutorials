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
    
    @IBOutlet weak var textView: FrameTextView!
    
    @IBAction func discardChanges(sender: UIBarButtonItem) {
        let dialogDiscard = UIAlertController(title: "Discard all changes?",
                                                    message: "",
                                                    preferredStyle: .Alert)
        
        let actionDiscard = UIAlertAction(title: "Discard changes", style: .Destructive , handler: {(action) in
            print("response: \(action)")
            
        })
        dialogDiscard.addAction(actionDiscard)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .Default, handler: {(action) in
            print("response: \(action)")
        })
        dialogDiscard.addAction(actionCancel)
        
        self.presentViewController(dialogDiscard, animated: false, completion: {})
    }
    
    override func viewDidLoad() {
        if (EditService.sharedInstance.isClass(Paragraph)) {
            textView.text = (EditService.sharedInstance.currentEntity! as! Paragraph).text
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        if let currentParagraph: Paragraph = EditService.sharedInstance.currentEntity as? Paragraph {
            currentParagraph.lastChange = NSDate()
            currentParagraph.text = textView.text
        }
        CoreDataService.sharedInstance.saveContext()
    }
}