//
//  DatabaseConnector.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 28.08.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import Foundation
import CoreData

class DatabaseConnector {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    func seedLessons(){
        let days = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag"]
        let times = [(hour: 08, minute: 15),(hour: 10, minute: 0),(hour: 11, minute: 45),(hour: 13, minute: 30),(hour: 15, minute: 15),(hour: 17, minute: 0),(hour: 18, minute: 45)]
        var moduleID: Int16 = 0
        for day in days{
            for time in times {
                let lesson = NSEntityDescription.insertNewObjectForEntityForName("Lesson", inManagedObjectContext: context) as! Lesson
                lesson.day = day
                lesson.hour = "\(time.hour)"
                lesson.minute = "\(time.minute)"
                lesson.room = ""
                lesson.suffix = ""
                lesson.moduleName = ""
                lesson.moduleID = moduleID
                moduleID++
                lesson.teacherID = ""
            }
            
        }
        do {
            try context.save()
        } catch _ {
        }
    }
    
    func printLessons(){
        let lessonFetchRequest = NSFetchRequest(entityName: "Lesson")
        let primarySortDescriptor = NSSortDescriptor(key: "moduleID", ascending: true)
        lessonFetchRequest.sortDescriptors = [primarySortDescriptor]
        
        let allLessons = (try! context.executeFetchRequest(lessonFetchRequest)) as! [Lesson]
        for lesson in allLessons{
            lesson.printLesson()
        }
        
    }
    
    func printOne(){
        //let predicate = NSPredicate(format: "moduleID == %@", 3)
        let predicate = NSPredicate(format: "day == %@ && hour == %@", argumentArray: ["Montag", "10"])
        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        fetchRequest.predicate = predicate
        
        let fetchedEntities = (try! context.executeFetchRequest(fetchRequest)) as! [Lesson]
        for lesson in fetchedEntities {
            lesson.printLesson()
        }
        
    }
    
    func updateEntity(keys: [String], values: (moduleName: String, room: String, suffix: String, teacherID: String)){
        print("update value")
        print(keys)
        print(values)
        //let predicate = NSPredicate(format: "moduleID == %@", 3)
        let predicate = NSPredicate(format: "day == %@ && hour == %@", argumentArray: keys)
        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        fetchRequest.predicate = predicate
        
        let fetchedEntities = (try! context.executeFetchRequest(fetchRequest)) as! [Lesson]
        print(fetchedEntities)
        if let lesson = fetchedEntities.first {
            //print("\(lesson.moduleID), \(lesson.day), \(lesson.hour)")
            //lesson.moduleName = values.
            lesson.moduleName = values.moduleName
            lesson.room = values.room
            lesson.suffix = values.suffix
            lesson.teacherID = values.teacherID
        }
        do {
            try context.save()
        } catch _ {
        }
    }
    
    func getLessonsForDay(day: String) -> [Lesson] {
        let predicate = NSPredicate(format: "day == %@", argumentArray: [day])
        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        fetchRequest.predicate = predicate
        let primarySortDescriptor = NSSortDescriptor(key: "moduleID", ascending: true)
        fetchRequest.sortDescriptors = [primarySortDescriptor]
        
        let fetchedEntities = (try! context.executeFetchRequest(fetchRequest)) as! [Lesson]
//        for lesson in fetchedEntities {
//            lesson.printLesson()
//        }
        return fetchedEntities
    }

    func saveTeacher(id: String, name: String){
        let predicate = NSPredicate(format: "id == %@", argumentArray: [id])
        let fetchRequest = NSFetchRequest(entityName: "Person")
        fetchRequest.predicate = predicate
        let fetchedEntities = (try! context.executeFetchRequest(fetchRequest)) as! [Teacher]
        if fetchedEntities.count == 0 {
            let teacher = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: context) as! Teacher
            teacher.id = id
            teacher.name = name
            do {
                try context.save()
            } catch _ {
            }
        }
    }
    
    func getTeacher(id: String) -> Teacher? {
        let predicate = NSPredicate(format: "id == %@", argumentArray: [id])
        let fetchRequest = NSFetchRequest(entityName: "Person")
        fetchRequest.predicate = predicate
        let fetchedEntities = (try! context.executeFetchRequest(fetchRequest)) as! [Teacher]
        if fetchedEntities.count > 0 {
            return fetchedEntities.first!
        } else {
            return nil
        }
    }
    
    func clearLessons() {
        let days = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag"]
        let times = [(hour: 08, minute: 15),(hour: 10, minute: 0),(hour: 11, minute: 45),(hour: 13, minute: 30),(hour: 15, minute: 15),(hour: 17, minute: 0),(hour: 18, minute: 45)]
        for day in days{
            for time in times {
                updateEntity([day, "\(time.hour)"], values: (moduleName: "", room: "", suffix: "", teacherID: ""))
            }
        }
    }
    
    func getLesson(day: String, hour: String) -> Lesson {
        let predicate = NSPredicate(format: "day == %@ && hour == %@", argumentArray: [day, hour])
        let fetchRequest = NSFetchRequest(entityName: "Lesson")
        fetchRequest.predicate = predicate
        
        let fetchedEntities = (try! context.executeFetchRequest(fetchRequest)) as! [Lesson]
        return fetchedEntities[0]
    }
    
}


