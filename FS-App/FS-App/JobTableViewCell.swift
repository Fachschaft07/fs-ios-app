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
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    func updateUI(){
        typeLabel?.text = nil
        companyLabel?.text = nil
        titleLabel?.text = nil
        
        
        if let job = self.job{
            typeLabel?.text = job.type ?? "err type"
            companyLabel?.text = job.company ?? "err company"
            titleLabel?.text = job.title ?? "err Title"
        }
    }
}
