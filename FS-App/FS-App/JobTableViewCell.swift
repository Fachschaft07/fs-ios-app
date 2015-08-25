//
//  JobTableViewCell.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 01.07.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    var job: Job? {
        didSet{
            updateUI()
        }
    }
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    
    
    func updateUI(){
        companyLabel?.text = nil
        titleLabel?.text = nil
        
        
        if let job = self.job{
            companyLabel?.text = job.provider ?? "err company"
            titleLabel?.text = job.title ?? "err Title"
        }
    }
}
