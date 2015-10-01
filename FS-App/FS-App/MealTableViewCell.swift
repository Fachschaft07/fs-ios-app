//
//  MealTableViewCell.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 06.09.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    var meal: Meal?{
        didSet{
            updateUI()
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    private func updateUI(){
        nameLabel.text = nil
        typeLabel.text = nil
        
        if let meal = self.meal {
            nameLabel.text = meal.name
            typeLabel.text = meal.type
        }
        
    }
}
