//
//  PartyViewController.swift
//  DungeonGame
//
//  Created by Vojtech Kubat on 3/17/16.
//  Copyright © 2016 CertiCon a.s. All rights reserved.
//

import Foundation
import UIKit

class PartyViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return PartyMemberTCViewController.height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("partyMember") as! PartyMemberTCViewController
        cell.crewNameLabel.text = "Crew member name ..."
        return cell
    }
    
}