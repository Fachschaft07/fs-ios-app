//
//  NewsTableViewCell.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 05.09.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var newsEntry: NewsEntry?{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        titleLabel.text = nil
        dateLabel.text = nil
        
        if let newsEntry = self.newsEntry{
            titleLabel.text = newsEntry.title
            
            let formatter = NSDateFormatter();
            formatter.dateFormat = "dd.MM.yy";
            let date = formatter.stringFromDate(newsEntry.date);
            
            dateLabel.text = date
        }
    }
}
