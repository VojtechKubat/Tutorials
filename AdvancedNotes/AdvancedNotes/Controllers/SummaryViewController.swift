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
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    @IBAction func addAttachment(sender: UIBarButtonItem) {
        
//        dispatch_async(dispatch_get_main_queue(), {
//            let addAttachmentDialog = UIAlertController(title: "Add new attachment",
//                message: "What do you want to add to your note?",
//                preferredStyle: .ActionSheet )
//            
//            
//            let addText = UIAlertAction(title: "Text note", style: .Default , handler: {(action) in
//                
//            })
//            addAttachmentDialog.addAction(addText)
//            //        let addImage = UIAlertAction(title: "Image", style: .Default, handler: {(action) in
//            //
//            //        })
//            //        addAttachmentDialog.addAction(addImage)
//            
//            
//            addAttachmentDialog.popoverPresentationController?.sourceView = self.view
//            addAttachmentDialog.popoverPresentationController?.barButtonItem = self.addBarButton
//            
//            
//            
//            self.presentViewController(addAttachmentDialog, animated: false, completion: {})
//        
//        })
//        

        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Delete", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
//            println("File Deleted")
        })
        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
//            println("File Saved")
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
//            println("Cancelled")
        })
        
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
//        let popPresenter = optionMenu.popoverPresentationController
//        popPresenter?.sourceView = self.navigationItem.titleView
//        popPresenter?.sourceRect = self.view.bounds
        
        
        optionMenu.popoverPresentationController?.sourceView = (self.navigationController?.view)
        optionMenu.popoverPresentationController?.sourceRect = (self.navigationController?.view.bounds)!

        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(">>> \(self.navigationController?.view.bounds)")
        
        print(">>> \(self.navigationController?.navigationController?.view)")
        print(">>> \(self.navigationController?.navigationController?.view.bounds)")
    }
    
    override var description: String {
        return ("\(super.description) - SummaryViewController")
    }

}