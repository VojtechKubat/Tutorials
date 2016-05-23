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

let cellDefaultID = "defaultCell"
let cellParagraphID = "cellParagraph"
let cellPictureID = "cellPicture"
let cellReminderID = "cellReminder"

class SummaryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var sort = NSSortDescriptor(key: "getLastChange", ascending: false)
    
    var note: Note? {
        didSet {
            contentSet = Set<ANEntity>()
            contentSet = contentSet.union(note?.hasParagraph as! Set)
            contentSet = contentSet.union(note?.hasPicture as! Set)
            contentSet = contentSet.union(note?.hasReminder as! Set)
            contentSet = contentSet.union(note?.hasChild as! Set)
            
            contentListFiltered = Array(contentSet)
            contentListFiltered = (Array(contentSet) as NSArray).sortedArrayUsingDescriptors([sort]) as! Array<ANEntity>
            
//            print("----------------------------------")
//            print("\(contentListFiltered)")
            
        }
    }
    
    var contentSet = Set<ANEntity>()
    var contentListFiltered = Array<ANEntity>()
    
    @IBAction func addAttachment(sender: UIBarButtonItem) {
        let addAttachmentDialog = UIAlertController(title: "Add new attachment",
            message: "What do you want to add to your note?",
            preferredStyle: .ActionSheet )
        
        let addParagraph = UIAlertAction(title: "Text note", style: .Default , handler: {(action) in
            self.performSegueWithIdentifier("addParagraphSegue", sender: self)
        })
        addAttachmentDialog.addAction(addParagraph)
        
        let addImage = UIAlertAction(title: "Image", style: .Default, handler: {(action) in
            self.performSegueWithIdentifier("addPictureSegue", sender: self)
        })
        addAttachmentDialog.addAction(addImage)
    
        addAttachmentDialog.popoverPresentationController?.barButtonItem = sender
        addAttachmentDialog.view.layoutIfNeeded()
    
        self.presentViewController(addAttachmentDialog, animated: false, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "ParagraphCellView", bundle: nil) , forCellReuseIdentifier: cellParagraphID)
        tableView.registerNib(UINib(nibName: "PictureCellView", bundle: nil) , forCellReuseIdentifier: cellPictureID)
        tableView.registerNib(UINib(nibName: "ReminderCellView", bundle: nil) , forCellReuseIdentifier: cellReminderID)
        
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
        if let _ = contentListFiltered[indexPath.row] as? Paragraph {
            let cell = tableView.dequeueReusableCellWithIdentifier(cellParagraphID)
            // as! ANTableViewCell
            
            // todo
            
            return cell!
        }
        
        if let _ = contentListFiltered[indexPath.row] as? Picture {
            let cell = tableView.dequeueReusableCellWithIdentifier(cellPictureID) as! ANTableViewCell
            
            // todo
            
            return cell
        
        }
        
        if let _ = contentListFiltered[indexPath.row] as? Reminder {
            let cell = tableView.dequeueReusableCellWithIdentifier(cellReminderID) as! ANTableViewCell
            
            // todo
            
            return cell
            
        }
        
        return (tableView.dequeueReusableCellWithIdentifier("cellDefault"))!
    }
}

extension SummaryViewController: UITableViewDelegate {
    
}