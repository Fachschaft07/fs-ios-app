//
//  BlackboardJSONParser.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 28.07.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import Foundation

class BlackboardJSONParser {
    
    func parse(data: NSData) -> [Entry]{
        var blackboardEntries: [Entry] = [Entry]()
  
        
        let jsonResult: NSArray = (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSArray)!
        
        for entry in jsonResult {
            let id: String = entry.valueForKey("id") as! String
            let authorData: NSDictionary = entry.valueForKey("author") as! NSDictionary
            let author: Person
            if authorData.count > 0 {
                let id: String = authorData.valueForKey("id") as! String
                let name: String = authorData.valueForKey("name") as! String
                author = Person(id: id, name: name)
            } else {
                author = Person(id: "", name:"")
            }
            
            
            let subject: String = entry.valueForKey("subject") as! String
            let text: String = entry.valueForKey("text") as! String
            
            var teachers: [Person] = [Person]()
            if let teachersData: NSArray = entry.valueForKey("teachers") as? NSArray{
                for personData in teachersData {
                    if let personData: NSDictionary = personData as? NSDictionary{
                        let person: Person = Person(id: personData.valueForKey("id") as! String,
                            name: personData.valueForKey("name") as! String)
                        
                        teachers.append(person)
                    }
                }
            }

            var groups: [Group] = [Group]()
            if let groupsData: NSArray = entry.valueForKey("groups") as? NSArray{
                for groupData in groupsData {
                    if let groupData: NSDictionary = groupData as? NSDictionary{
                        let semester: Int = groupData.valueForKey("semester") as? Int ?? 0
                        let letter: String = groupData.valueForKey("letter") as? String ?? ""
                        let study: String = groupData.valueForKey("study") as? String ?? ""
                        
                        let group: Group = Group(semester: semester, letter: letter, study: study)
                        groups.append(group)
                    }
                }
            }
            
                        
            let publish: Double = entry.valueForKey("publish") as! Double
            let url: String = entry.valueForKey("url") as! String
            
            let foundEntry: Entry = Entry(id: id, author: author, subject: subject, text: text, teachers: teachers, groups: groups, publish: publish, url: url)
            
            blackboardEntries.append(foundEntry)
        }
        
        return blackboardEntries.sort {$0.publish > $1.publish}
    }
}