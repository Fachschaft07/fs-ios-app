//
//  LostAndFoundJSONParser.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 29.09.15.
//  Copyright © 2015 Fachschaft07. All rights reserved.
//

import Foundation

class LostAndFoundJSONParser {
    
    func parse(data: NSData) -> [LostAndFoundEntry] {
        var lostAndFoundEntries = [LostAndFoundEntry]()
        
        let jsonResult: NSArray = ((try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSArray)
        
        for currentEntry in jsonResult {
            let subject: String = currentEntry.valueForKey("subject") as! String
            let date: NSDate = NSDate(timeIntervalSince1970: (currentEntry.valueForKey("date") as! Double)/1000)
            
            lostAndFoundEntries.append(LostAndFoundEntry(subject: subject, date: date))
            
        }
        
        
        return lostAndFoundEntries
    }
}