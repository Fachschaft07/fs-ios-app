//
//  NewsJSONParser.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 06.09.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import Foundation

class NewsJSONParser {
    
    func parse(data: NSData) -> [NewsEntry]{
        var news: [NewsEntry] = [NewsEntry]()
        
        
        
        let jsonResult: NSArray = (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSArray)!
        
        
        for currentNewsEntry in jsonResult {
            let title: String = currentNewsEntry.valueForKey("title") as! String
            let link: String = currentNewsEntry.valueForKey("link") as! String
            let date: NSDate = NSDate(timeIntervalSince1970: (currentNewsEntry.valueForKey("date") as! Double)/1000)
            let description: String = currentNewsEntry.valueForKey("description") as! String
            
            news.append(NewsEntry(title: title, content: description, date: date, url: link))
        }
        
        return news
    }
}