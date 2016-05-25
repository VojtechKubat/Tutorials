//
//  ParagraphCellView.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 23/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import UIKit

class ParagraphViewCell: UITableViewCell {
    
    weak var myParagraph: Paragraph?
    
    @IBOutlet weak var paragraphTextView: FrameTextView!
    
    @IBAction func remove(sender: UIButton) {
        print("remove")
    }
    
    @IBAction func edit(sender: UIButton) {
        print("edit")
    }
    
    func setParagraph (paragraph: Paragraph) {
        myParagraph = paragraph
        
        if let _ = myParagraph {
            paragraphTextView.text = myParagraph!.text
        }
    }

}