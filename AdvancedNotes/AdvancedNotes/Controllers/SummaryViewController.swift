//
//  SummaryViewController.swift
//  AdvanceNote
//
//  Created by Vojtech Kubat on 09/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SummaryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var sort = NSSortDescriptor(key: "getLastChange", ascending: false)
    
    var note: Note? {
        didSet {
//            contentList.appendContentsOf(note?.hasParagraph as! Set)
//            contentList.appendContentsOf(note?.hasPicture as! Set)
//            contentList.appendContentsOf(note?.hasReminder as! Set)
            contentSet = Set<ANEntity>()
            contentSet = contentSet.union(note?.hasParagraph as! Set)
            contentSet = contentSet.union(note?.hasPicture as! Set)
            contentSet = contentSet.union(note?.hasReminder as! Set)
            contentSet = contentSet.union(note?.hasChild as! Set)
            
            print("----------------------------------")
            print("\(contentSet)")
            
            contentListFiltered = Array(contentSet)
            
            print("----------------------------------")
            print("\(contentListFiltered)")
           
            contentListFiltered = (Array(contentSet) as NSArray).sortedArrayUsingDescriptors([sort]) as! Array<ANEntity>
            
            print("----------------------------------")
            print("\(contentListFiltered)")
            
        }
    }
    
    var contentSet = Set<ANEntity>()
    var contentListFiltered = Array<ANEntity>()
    
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
        return contentListFiltered.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCellWithIdentifier("paragraphCell"))!
        return cell
    }
}

extension SummaryViewController: UITableViewDelegate {
    
}