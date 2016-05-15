//
//  MainCellViewController.swift
//  AdvanceNote
//
//  Created by Vojtech Kubat on 06/5/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var leftHeading: NSLayoutConstraint!
    
    func configureCell(headline: String) {
        headlineLabel.text = headline
    }
    
}