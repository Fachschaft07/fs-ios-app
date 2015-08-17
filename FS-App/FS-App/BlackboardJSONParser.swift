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
            var subject: String = entry.valueForKey("subject") as! String
            var author: String = entry.valueForKey("author") as! String
            var text: String = entry.valueForKey("text") as! String
            var teacher: String
            var group: String
            var publish: NSDate
            var expire: NSDate

        
        }
        
        return blackboardEntries
    }
}