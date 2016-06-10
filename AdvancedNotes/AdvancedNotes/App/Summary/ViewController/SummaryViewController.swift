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
    
    let compareByLastChange = {(element1: ANEntity, element2: ANEntity) -> Bool in
        return (element1.getLastChange.compare(element2.getLastChange) == .OrderedDescending)
    }
    
    var note: Note? {
        didSet {
            contentSet = Set<ANEntity>()
            contentSet = contentSet.union(note?.hasParagraph as! Set)
            contentSet = contentSet.union(note?.hasPicture as! Set)
            contentSet = contentSet.union(note?.hasReminder as! Set)
            contentSet = contentSet.union(note?.hasChild as! Set)
            
            contentListFiltered = (Array(contentSet) as Array<ANEntity>).sort(compareByLastChange)
        }
    }
    
    var contentSet = Set<ANEntity>()
    var contentListFiltered = Array<ANEntity>()
    
    @IBAction func addAttachment(sender: UIBarButtonItem) {
        let addAttachmentDialog = UIAlertController(title: "Add new attachment",
            message: "What do you want to add to your note?",
            preferredStyle: .ActionSheet )
        
        let addParagraph = UIAlertAction(title: "Text note", style: .Default , handler: {(action) in
            EditService.sharedInstance.currentEntity = nil
            
            if (self.note != nil) {
                let paragraphED = NSEntityDescription.entityForName("Paragraph",
                    inManagedObjectContext: (self.note?.managedObjectContext)!)!
                
                let newParagraph = NSManagedObject(entity: paragraphED,
                    insertIntoManagedObjectContext: (self.note?.managedObjectContext)!)
                let allParagraphs: NSMutableSet = (self.note!.hasParagraph?.mutableCopy())! as! NSMutableSet
                allParagraphs.addObject(newParagraph)
                self.note!.hasParagraph = allParagraphs
                EditService.sharedInstance.currentEntity = newParagraph as? ANEntity
                
                self.performSegueWithIdentifier("addParagraphSegue", sender: self)
            }
            
        })
        addAttachmentDialog.addAction(addParagraph)
        
        let addImage = UIAlertAction(title: "Image", style: .Default, handler: {(action) in
            if (self.note != nil) {
                EditService.sharedInstance.currentEntity = nil
                self.performSegueWithIdentifier("addPictureSegue", sender: self)
            }
        })
        addAttachmentDialog.addAction(addImage)
    
        addAttachmentDialog.popoverPresentationController?.barButtonItem = sender
        addAttachmentDialog.view.layoutIfNeeded()
    
        self.presentViewController(addAttachmentDialog, animated: false, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.registerNib(UINib(nibName: "ParagraphCellView", bundle: nil) , forCellReuseIdentifier: cellParagraphID)
        tableView.registerNib(UINib(nibName: "PictureCellView", bundle: nil) , forCellReuseIdentifier: cellPictureID)
        tableView.registerNib(UINib(nibName: "ReminderCellView", bundle: nil) , forCellReuseIdentifier: cellReminderID)
     
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(refresh),
                                                         name: changesPerformedKey,
                                                         object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func refresh() {
        tableView.reloadData()
    }
    
    override var description: String {
        return ("\(super.description) - SummaryViewController")
    }
    
    func editItem(entitiy: ANEntity?) {
        if (entitiy == nil) {
            return
        }
        EditService.sharedInstance.currentEntity = entitiy
        
        if (entitiy!.isKindOfClass(Paragraph)) {
            self.performSegueWithIdentifier("addParagraphSegue", sender: self)
        }
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
        var cell: UITableViewCell?
        if let _ = contentListFiltered[indexPath.row] as? Paragraph {
            cell = tableView.dequeueReusableCellWithIdentifier(cellParagraphID)
            (cell as! ParagraphViewCell).setParagraph(contentListFiltered[indexPath.row] as! Paragraph)
        }
        
        if let _ = contentListFiltered[indexPath.row] as? Picture {
            cell = tableView.dequeueReusableCellWithIdentifier(cellPictureID)!
            // todo
            
        }
        
        if let _ = contentListFiltered[indexPath.row] as? Reminder {
            cell = tableView.dequeueReusableCellWithIdentifier(cellReminderID)!
            // todo
            
        }
        
        if (cell != nil) {
            (cell as! SummaryCellView).parentVC = self
            return cell!
        }
        return (tableView.dequeueReusableCellWithIdentifier("cellDefault"))!
    }
    
}

extension SummaryViewController: UITableViewDelegate {
    
}