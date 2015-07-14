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
    private var publicTransport: [PublicTransport] = [PublicTransport]()
    
    func parse(data: NSData) ->[PublicTransport]{
        publicTransport.removeAll()
        
        
        
        var error: NSError?
        let jsonResult:NSArray = (NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers , error: &error) as? NSArray)!
        
        
        for current in jsonResult{
            var line: String = current.valueForKey("line")as! String
            
            var destination: String =  current.valueForKey("destination")as! String
            var timeFromRest: Double = current.valueForKey("departure") as! Double
            var time = (timeFromRest/1000)
            var now = NSDate().timeIntervalSince1970
            var diff = (time-now)/60
            var departure = String(format: "%.0f", diff)
            let tmp = PublicTransport(line: line, destination: destination, depature: departure)
            publicTransport.append(tmp)
        }
        return publicTransport
    }
}