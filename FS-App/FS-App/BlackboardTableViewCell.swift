//
//  BlackboardTableViewCell.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 28.07.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class BlackboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    
    var entry: Entry?{
        didSet{
            updateUI()
        }
    }

    
    func updateUI(){
        titleLabel?.text = nil
        groupLabel?.text = nil
        
        if let entry = self.entry {
            titleLabel?.text = entry.subject
            var groups:String = "All"
            if entry.groups.count > 0{
                groups = ""
                for group in entry.groups {
                    var currentGroup: String = group.study
                    
                    if group.semester != 0{
                        currentGroup = "\(currentGroup) \(group.semester)"
                    }
                    if group.letter != ""{
                        currentGroup = "\(currentGroup) \(group.letter)"
                    }
                    if !groups.contains(currentGroup) {
                        groups = "\(groups) \(currentGroup),"
                    }
                    
                    
                }
            }
            groupLabel?.text = groups
        }
    }
    
}
