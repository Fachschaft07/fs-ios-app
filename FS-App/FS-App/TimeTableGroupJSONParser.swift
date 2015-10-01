//
//  TimeTableGroupJSONParser.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 29.09.15.
//  Copyright © 2015 Fachschaft07. All rights reserved.
//

import Foundation

class TimeTableGroupJSONParser {
    
    
    func parse(data: NSData) -> [GroupLesson]{
        var groupLessons: [GroupLesson] = [GroupLesson]()
        
        let jsonResult:NSArray = (try! NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers ) as? NSArray)!
        
        
        for current in jsonResult{
            
            let group = current.valueForKey("group") as! NSDictionary
            
            let letterFromJSON = group.valueForKey("letter")//as! String
            var letter = ""
            if let tmp = letterFromJSON as? String{
                letter = tmp
            }
            let semesterFromJSON = group.valueForKey("semester")
            var semester = ""
            if let tmp = semesterFromJSON as? String {
                semester = tmp.replaceAll("_", with: "")
            }
            //let semester = (group.valueForKey("semester") as! String).replaceAll("_", with: "")
            let study = group.valueForKey("study") as! String
            
            let module = current.valueForKey("module") as! NSDictionary
            let moduleID = module.valueForKey("id") as! String
            let moduleName = module.valueForKey("name") as! String
            
            let teacher = current.valueForKey("teacher") as! NSDictionary
            let teacherID = teacher.valueForKey("id") as! String
            let teacherName = teacher.valueForKey("name") as! String
            
            let groups = current.valueForKey("groups") as! [Int]
            
            
            
            
            
            let tmp = GroupLesson(letter: letter, semester: semester, study: study, moduleID: moduleID, moduleName: moduleName, teacherID: teacherID, teacherName: teacherName, groups: groups)
            groupLessons.append(tmp)
        }
        
        return groupLessons
    }
}