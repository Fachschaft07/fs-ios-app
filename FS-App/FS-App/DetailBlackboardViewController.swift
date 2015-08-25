//
//  DetailBlackboardViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 20.08.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class DetailBlackboardViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var text: String = ""
        
        
        // set Text
        if let entry = self.entry{
            text = entry.subject
            var time: NSDate = NSDate(timeIntervalSince1970: entry.publish/1000)
            var formatter = NSDateFormatter();
            formatter.dateFormat = "dd.MM.yyyy";
            let date = formatter.stringFromDate(time);
            text = "\(text)\nErstellt am: \(date)\n\n\(entry.text)"
            var contactData: Person = entry.author
            var contact: String = "Erstellt von:\n\(contactData.title)\n\(contactData.firstName) \(contactData.lastName)"
            text = "\(text)\n\n\n\(contact)"
            var teachers: String = "Betroffene Professoren:"
            for teacher in entry.teachers {
                teachers = "\(teachers)\n\(teacher.title) \(teacher.firstName) \(teacher.lastName)"
            }
            text = "\(text)\n\n\(teachers)"
            var groups: String = "Betroffene Gruppen:\n"
            if entry.groups.count == 0 {
                groups = "\(groups)Alle"
            } else {
                let bulletPoint: Character = "•"
                for group in entry.groups {
                    var currentGroup: String = group.study
                    var semester = ""
                    if group.semester != 0{
                        currentGroup = "\(currentGroup) \(group.semester)"
                    }
                    if group.letter != ""{
                        currentGroup = "\(currentGroup) \(group.letter)"
                    }
                    if !groups.contains(currentGroup) {
                        groups = "\(groups) \(bulletPoint) \(currentGroup)\n"
                    }
                    
                    
                    
                }
                // groups = "\(groups)\n\(group.study) \(group.semester) \(group.letter)"
            }
            text = "\(text)\n\n\(groups)"
        }
        textField.text? = text
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
