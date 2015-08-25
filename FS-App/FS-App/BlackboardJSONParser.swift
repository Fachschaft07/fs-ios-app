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
        var error: NSError?
        
        let jsonResult: NSArray = (NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? NSArray)!
        
        for entry in jsonResult {
            let id: String = entry.valueForKey("id") as! String
            //TODO: change from author to contact
            var authorData: NSDictionary = entry.valueForKey("author") as! NSDictionary
            let author: Person
            if authorData.count > 0 {
                var id: String = authorData.valueForKey("id") as! String
                var lastName: String = authorData.valueForKey("lastName") as! String
                var firstName: String = authorData.valueForKey("firstName") as! String
                var title: String = authorData.valueForKey("title") as! String
                
                author = Person(id: id,lastName: lastName, firstName: firstName, title: title)
            } else {
                author = Person(id: "",lastName:"",firstName:"", title:"")
            }
            
            
            let subject: String = entry.valueForKey("subject") as! String
            let text: String = entry.valueForKey("text") as! String
            
            var teachers: [Person] = [Person]()
            if var teachersData: NSArray = entry.valueForKey("teachers") as? NSArray{
                for personData in teachersData {
                    if let personData: NSDictionary = personData as? NSDictionary{
                        var person: Person = Person(id: personData.valueForKey("id") as! String,lastName: personData.valueForKey("lastName") as! String, firstName: personData.valueForKey("firstName") as! String, title: personData.valueForKey("title") as! String)
                        teachers.append(person)
                    }
                }
            }

            var groups: [Group] = [Group]()
            if var groupsData: NSArray = entry.valueForKey("groups") as? NSArray{
                for groupData in groupsData {
                    if let groupData: NSDictionary = groupData as? NSDictionary{
                        let semester: Int = groupData.valueForKey("semester") as? Int ?? 0
                        let letter: String = groupData.valueForKey("letter") as? String ?? ""
                        let study: String = groupData.valueForKey("study") as? String ?? ""
                        
                        var group: Group = Group(semester: semester, letter: letter, study: study)
                        groups.append(group)
                    }
                }
            }
            
                        
            let publish: Double = entry.valueForKey("publish") as! Double
            let url: String = entry.valueForKey("url") as! String
            
            var foundEntry: Entry = Entry(id: id, author: author, subject: subject, text: text, teachers: teachers, groups: groups, publish: publish, url: url)
            
            blackboardEntries.append(foundEntry)
        }
        
        return blackboardEntries
    }
}