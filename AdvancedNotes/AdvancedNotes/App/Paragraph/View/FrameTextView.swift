//
//  FrameTextView.swift
//  AdvancedNotes
//
//  Created by Vojtech Kubat on 13/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import UIKit

class FrameTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addBorders()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addBorders()
    }
    
    func addBorders(){
        layer.setValue(NSNumber(int: 1), forKey: "borderWidth")
        layer.setValue(NSNumber(int: 8), forKey: "cornerRadius")
        layer.setValue(UIColor.lightGrayColor().CGColor, forKey: "borderColor")
        
        textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8)
    }
}