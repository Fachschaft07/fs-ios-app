//
//  LessonJSONParser.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 29.09.15.
//  Copyright © 2015 Fachschaft07. All rights reserved.
//

import Foundation

class LessonJSONParser {
    
    func getGermanName(englishName: String)-> String {
        switch englishName {
        case "MONDAY":
            return days.Mo.fullDay
        case "TUESDAY":
            return days.Di.fullDay
        case "WEDNESDAY":
            return days.Mi.fullDay
        case "THURSDAY":
            return days.Do.fullDay
        case "FRIDAY":
            return days.Fr.fullDay
            
        default: return days.Mo.fullDay
        }
    }
    
    func parse(data: NSData, database: DatabaseConnector) {
        
        
        
        let jsonResult:NSArray = (try! NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers ) as? NSArray)!
        
        
        for currentLesson in jsonResult{
            let day = currentLesson.valueForKey("day") as! String
            let germanDay = getGermanName(day)
            
            let hour = currentLesson.valueForKey("hour") as! Int
//            let minute = currentLesson.valueForKey("minute") as! Int
            let room = currentLesson.valueForKey("room") as! String
            let suffix = currentLesson.valueForKey("suffix") as! String
            let module = currentLesson.valueForKey("module") as! NSDictionary
//            let moduleID = module.valueForKey("id") as! String
            let moduleName = module.valueForKey("name") as! String
            let teacher = currentLesson.valueForKey("teacher") as! NSDictionary
            let teacherID = teacher.valueForKey("id") as! String
            let teacherName = teacher.valueForKey("name") as! String
            
            database.updateEntity([germanDay, "\(hour)"], values: (moduleName: moduleName, room: room, suffix: suffix, teacherID: teacherID))
            database.saveTeacher(teacherID, name: teacherName)
            
        }

    }
}