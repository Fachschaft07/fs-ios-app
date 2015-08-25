//
//  URLs.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 30.06.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import Foundation

struct URLs {
    
    // Mark: - Final URLs
    static let loth = "http://fs.cs.hm.edu/rest/api/publicTransport?location=LOTHSTR"
    static let pasing = "http://fs.cs.hm.edu/rest/api/publicTransport?location=PASING"
    static let blackboardEntry = "http://fs.cs.hm.edu/rest/api/blackboard/entry"
    
    
    
    
    
    
    //Public transportaion urls
    //static let pasing = "http://192.168.2.173:8080/rest/api/mvv?location=PASING"
    //static let loth = "http://192.168.2.173:8080/rest/api/mvv?location=LOTHSTR"
    //room search url
    static let roomSearch = "http://fs.cs.hm.edu/roomSearch/RESTService/freeRooms?clockTime="
    //jobs
    //static let job = "http://192.168.2.173:8080/rest/api/job"
    
    //mensa
    
    //news
    //timetable
    
    //blackboard
    //static let blackboard = "http://192.168.2.173:8080/rest/api/blackboard/entry"
    
    
    
    
    
    //====== local urls =======
    // public transport
//    static let pasing = "http://127.0.0.1:8080/rest/api/mvv?location=PASING"
    //static let loth = "http://127.0.0.1:8080/rest/api/mvv?location=LOTHSTR"
    static let job = "http://127.0.0.1:8080/rest/api/job"
    static let blackboard = "http://127.0.0.1:8080/rest/api/blackboard/entry"
    static let exams = "http://127.0.0.1:8080/rest/api/exams"
    static let presence = "http://127.0.0.1:8080/rest/api/presence"
    static let room = "http://127.0.0.1:8080/rest/api/room"
    

}