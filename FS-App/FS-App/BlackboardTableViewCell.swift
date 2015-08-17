//
//  BlackboardTableViewCell.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 28.07.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class BlackboardTableViewCell: UITableViewCell {
    
    var entry: Entry?{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        
    }
    
}
