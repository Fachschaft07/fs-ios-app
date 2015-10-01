//
//  PublicTransportJSONParser.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 30.06.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//
/*
let line: String
let destination: String
let depature: String
*/
import Foundation

class PublicTransportJSONParser {
    
    
    func parse(data: NSData) ->[PublicTransport]{
        var publicTransport: [PublicTransport] = [PublicTransport]()
        
        let jsonResult:NSArray = (try! NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers ) as? NSArray)!
        
        
        for current in jsonResult{
            let line: String = current.valueForKey("line")as! String
            
            let destination: String =  current.valueForKey("destination")as! String
            let timeFromRest: Double = current.valueForKey("departure") as! Double
            let time = (timeFromRest/1000)
            let now = NSDate().timeIntervalSince1970
            let diff = ((time-now)/60) > 0 ? ((time-now)/60) : 0
            let departure = String(format: "%.0f", diff)
            let tmp = PublicTransport(line: line, destination: destination, depature: departure)
            publicTransport.append(tmp)
        }
        return publicTransport
    }
}