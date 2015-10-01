//
//  AddLessonTableViewCell.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 29.09.15.
//  Copyright © 2015 Fachschaft07. All rights reserved.
//

import UIKit
import CoreData

class AddLessonTableViewCell: UITableViewCell {
    
    var lesson: GroupLesson? {
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var moduleNameLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!


    
    func updateUI() {
        moduleNameLabel.text = nil
        teacherLabel.text = nil
        
        if let lesson = self.lesson {
            moduleNameLabel.text = lesson.moduleName
            teacherLabel.text = lesson.teacherName
            if lesson.groups.count > 1 {
                
                let items = ["1", "2", "3"]
                let segmentedControl = UISegmentedControl(items: items)
                let size = teacherLabel.frame.size
                let position = teacherLabel.frame.origin
                segmentedControl.frame = CGRect(x: position.x, y: position.y + size.height + 8, width: size.width, height: size.height)
                
                segmentedControl.selectedSegmentIndex = 0
                self.addSubview(segmentedControl)
            }
        }
    }
    
    
    @IBAction func statusChanged(sender: UISwitch) {
        //static let lesson = "http://fs.cs.hm.edu/rest/api/1/timetable/lessons?group=ic3&module=softwareengineeringi&teacher=hammerschallulrike&pk=1"
        //let url = URLs.lesson
        if sender.on{
            if let lesson = self.lesson{
                let group = "\(lesson.study)\(lesson.semester)\(lesson.letter)"
                let module = lesson.moduleID
                let teacher = lesson.teacherID
                let pk = "1"
                let url = "\(URLs.lesson)\(group)&module=\(module)&teacher=\(teacher)&pk=\(pk)"
                print(url)
                let nsurl = NSURL(string: url)
                
                if let url = nsurl {
                    let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
                    dispatch_async(dispatch_get_global_queue(qos,0)) {() -> Void in
                        if let jsonData: NSData = NSData(contentsOfURL: url){
                            dispatch_async(dispatch_get_main_queue()){
                                let parser = LessonJSONParser()
                                
                                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                                let context = appDelegate.managedObjectContext
                                let database: DatabaseConnector = DatabaseConnector(context: context!)
                                parser.parse(jsonData, database: database)
                                print("done")
                            }
                        }
                    }
                }
            }
        }
    }
}
