//
//  RoomSearchJSONParser.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 18.08.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import Foundation

class RoomSearchJSONParser {
    
    private var rooms = [Room]()
    
    func parse(data: NSData) ->[Room]{
        rooms.removeAll()
        
        
        
        var error: NSError?
        let jsonResult:NSArray = (NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers , error: &error) as? NSArray)!
        
        for current in jsonResult{
            var name: String = current.valueForKey("name")as! String
            
            var hour: Int =  current.valueForKey("hour")as! Int
            var minute: Int = current.valueForKey("minute") as! Int
            
            let tmp = Room(roomName: name, freeUntil:"\(hour):\(minute)")
            
            rooms.append(tmp)
        }
        
        return rooms
    }

}