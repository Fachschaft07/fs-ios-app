//
//  ExamModuleTableViewCell.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 10.07.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class ExamModuleTableViewCell: UITableViewCell {
    
    var examModule: ExamModule? {
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func updateUI() {
        titleLabel?.text = nil
        
        if let examModule = self.examModule {
            titleLabel?.text = examModule.name
        }
    }
}
