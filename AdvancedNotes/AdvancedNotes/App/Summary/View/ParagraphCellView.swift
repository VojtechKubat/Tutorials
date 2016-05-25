//
//  ParagraphCellView.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 23/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import UIKit

class ParagraphViewCell: ANTableViewCell {
    
    @IBOutlet weak var paragraphTextView: FrameTextView!
    
    
    
    func setParagraph (paragraph: Paragraph) {
        paragraphTextView.text = paragraph.text
        layoutIfNeeded()
    }
    
    override func height() -> CGFloat {
        return 20
    }
}