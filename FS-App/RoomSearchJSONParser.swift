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
        
        
        
        let jsonResult:NSArray = (try! NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers ) as? NSArray)!
        
        for current in jsonResult{
            let name: String = current.valueForKey("name")as! String
            
            let hour: Int =  current.valueForKey("hour")as! Int
            let minute: Int = current.valueForKey("minute") as! Int
            let formatter = NSNumberFormatter()
            formatter.minimumIntegerDigits = 2
            
            let tmp = Room(roomName: name, freeUntil:"\(formatter.stringFromNumber(hour)!):\(formatter.stringFromNumber(minute)!)")
            
            rooms.append(tmp)
        }
        
        return rooms
    }

}