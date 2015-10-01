//
//  LostAndFoundTableViewCell.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 29.09.15.
//  Copyright © 2015 Fachschaft07. All rights reserved.
//

import UIKit

class LostAndFoundTableViewCell: UITableViewCell {

    
    var entry: LostAndFoundEntry? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    
    private func updateUI(){
    
        titleLabel.text = nil
        dateLabel.text = nil
        
        if let entry = self.entry {
            titleLabel.text = entry.subject
            let formatter = NSDateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let date = formatter.stringFromDate(entry.date)
            dateLabel.text = date
            
        }
    }
}
