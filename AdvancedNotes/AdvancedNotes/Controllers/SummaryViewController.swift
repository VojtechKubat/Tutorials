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
    @IBOutlet weak var tableView: UITableView!
    
    var note: Note?
    
    @IBAction func addAttachment(sender: UIBarButtonItem) {
        let addAttachmentDialog = UIAlertController(title: "Add new attachment",
            message: "What do you want to add to your note?",
            preferredStyle: .ActionSheet )
        
        let addParagraph = UIAlertAction(title: "Text note", style: .Default , handler: {(action) in
            self.performSegueWithIdentifier("", sender: self)
        })
        addAttachmentDialog.addAction(addParagraph)
        
        let addImage = UIAlertAction(title: "Image", style: .Default, handler: {(action) in
        })
        addAttachmentDialog.addAction(addImage)
    
        addAttachmentDialog.popoverPresentationController?.barButtonItem = sender
        addAttachmentDialog.view.layoutIfNeeded()
    
        self.presentViewController(addAttachmentDialog, animated: false, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var description: String {
        return ("\(super.description) - SummaryViewController")
    }
}

extension SummaryViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = note {
            var summaryItems: Int = 0
            summaryItems += (note?.hasParagraph?.count)!
            summaryItems += (note?.hasPicture?.count)!
            summaryItems += (note?.hasChild?.count)!
            summaryItems += (note?.hasReminder?.count)!
            summaryItems += note?.hasParent != nil ? 1:0
            
            print("count of summary items: \(summaryItems)")
            return summaryItems
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCellWithIdentifier("paragraphCell"))!
        return cell
    }
}

extension SummaryViewController: UITableViewDelegate {
    
}