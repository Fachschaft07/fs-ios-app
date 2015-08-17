//
//  ExamJSONParser.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 16.07.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import Foundation

class ExamJSONParser {
    
    
    
    func parse(data: NSData) ->[ExamModule]{
        var examModules: [ExamModule] = [ExamModule]()
        //examModules.removeAll()
        
        
        
        var error: NSError?
        let jsonResult:NSArray = (NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers , error: &error) as? NSArray)!
        
        
        for currentJob in jsonResult{
            //var line: String = current.valueForKey("line")as! String
            var typeAndTitle: String = currentJob.valueForKey("title") as! String
            var x = split(typeAndTitle, maxSplit: 1, allowEmptySlices: true, isSeparator: { $0 == " " })
            
            var type: String = x[0]
            var title: String = x[1]
            
            var company: String = currentJob.valueForKey("provider") as! String
            var description: String = currentJob.valueForKey("description") as! String
            var url: String = currentJob.valueForKey("url") as! String
            
            
            
            let tmp = Job(type: type, title: title, company: company, description: description, url: url)
           // examModules.append(tmp)
        }
        return examModules
    }

}