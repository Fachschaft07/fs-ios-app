//
//  Lesson.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 25.08.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import Foundation
import CoreData


class Lesson: NSManagedObject {
    
    @NSManaged var day: String?
    @NSManaged var hour: String?
    @NSManaged var minute: String?
    @NSManaged var room: String?
    @NSManaged var suffix: String?
    @NSManaged var moduleName: String?
    @NSManaged var teacherID: String?
    @NSManaged var moduleID: Int16
    
    func printLesson(){
        print("\(moduleID)\t\(day!)\t\t\(hour!)\t\(minute!)\t\(moduleName!)\t\(room!)\t\(suffix!)\t\(teacherID!)asdf")
    }
}