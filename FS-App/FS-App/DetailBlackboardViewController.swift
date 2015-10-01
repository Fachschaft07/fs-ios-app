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
        textField.scrollEnabled = false
        textField.text? = text
        // set Text
        if let entry = self.entry{
            text = entry.subject
            let time: NSDate = NSDate(timeIntervalSince1970: entry.publish/1000)
            let formatter = NSDateFormatter();
            formatter.dateFormat = "dd.MM.yyyy";
            let date = formatter.stringFromDate(time);
            text = "\(text)\nErstellt am: \(date)\n\n\(entry.text)"
            let contactData: Person = entry.author
            let contact: String = "Erstellt von:\n\(contactData.name)"
            text = "\(text)\n\n\n\(contact)"
            var teachers: String = "Betroffene Professoren:"
            for teacher in entry.teachers {
                teachers = "\(teachers)\n\(teacher.name)"
            }
            text = "\(text)\n\n\(teachers)"
            var groups: String = "Betroffene Gruppen:\n"
            if entry.groups.count == 0 {
                groups = "\(groups)Alle"
            } else {
                let bulletPoint: Character = "•"
                for group in entry.groups {
                    var currentGroup: String = group.study
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
            let markupParser = MarkupParser()
            let attributedText = markupParser.parseString(text)
            textField.attributedText = attributedText
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textField.scrollEnabled = true
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
