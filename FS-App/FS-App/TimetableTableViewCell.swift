//
//  TimetableTableViewCell.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 25.08.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class TimetableTableViewCell: UITableViewCell {

    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var moduleNameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var suffixLabel: UILabel!
    
    var lesson: Lesson?{
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        fromLabel.text = nil
        
        moduleNameLabel.text = nil
        roomLabel.text = nil
        teacherLabel.text = nil
        suffixLabel.text = nil
        
        if let lesson = self.lesson{
            let formatter = NSNumberFormatter()
            formatter.minimumIntegerDigits = 2
            fromLabel.text = "\(formatter.stringFromNumber(Int(lesson.hour!)!)!):\(formatter.stringFromNumber(Int(lesson.minute!)!)!)"
//            fromLabel.text = "\(lesson.hour!):\(lesson.minute!)"
            moduleNameLabel.text = lesson.moduleName!
            roomLabel.text = lesson.room!
            if lesson.teacherID! != "" {
                teacherLabel.text = getProfName(lesson.teacherID!)
            }
            suffixLabel.text = lesson.suffix!
        }
    }
    
    func getProfName(profID: String) -> String {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let database: DatabaseConnector = DatabaseConnector(context: context!)
        return database.getTeacher(profID)!.name!
    }

}
