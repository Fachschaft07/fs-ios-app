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
    static let loth = "http://fs.cs.hm.edu/rest/api/1/publicTransport?location=LOTHSTR"
    static let pasing = "http://fs.cs.hm.edu/rest/api/1/publicTransport?location=PASING"
    static let blackboardEntry = "http://fs.cs.hm.edu/rest/api/1/blackboard"
    static let job = "http://fs.cs.hm.edu/rest/api/1/jobs"
    static let news = "http://fs.cs.hm.edu/rest/api/1/fs/news/"
    //static let roomSearch = "http://fs.cs.hm.edu/rest/api/1/room?time="
    static let roomSearch = "http://fs.cs.hm.edu/rest/api/1/room?type=ALL&day="
    static let meal = "http://fs.cs.hm.edu/rest/api/1/meal?location=MENSA_LOTHSTRASSE"
    static let lostAndFound = "http://fs.cs.hm.edu/rest/api/1/lostandfound"
    static let timeTableGroup = "http://fs.cs.hm.edu/rest/api/1/timetable/modules?group="
    static let lesson = "http://fs.cs.hm.edu/rest/api/1/timetable/lessons?group="
    
    /*
    
    /rest/api/{version}/
    /rest/api/1/blackboard
    /rest/api/1/calendar/termin
    /rest/api/1/calendar/holiday
    /rest/api/1/calendar/exam
    /rest/api/1/timetable/module?group={group}
    /rest/api/1/modules
    /rest/api/1/module?id={moduleID}
    /rest/api/1/room
    /rest/api/1/job
    /rest/api/1/lostandfound
    /rest/api/1/publicTransport
    /rest/api/1/meal
    /rest/api/1/fs/presence
    /rest/api/1/fs/news
    
    
    */
    
    
    
    
    //Public transportaion urls
    //static let pasing = "http://192.168.2.173:8080/rest/api/mvv?location=PASING"
    //static let loth = "http://192.168.2.173:8080/rest/api/mvv?location=LOTHSTR"
    //room search url
   // static let roomSearch = "http://fs.cs.hm.edu/roomSearch/RESTService/freeRooms?clockTime="
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
//    static let job = "http://127.0.0.1:8080/rest/api/job"
//    static let blackboard = "http://127.0.0.1:8080/rest/api/blackboard/entry"
//    static let exams = "http://127.0.0.1:8080/rest/api/exams"
//    static let presence = "http://127.0.0.1:8080/rest/api/presence"
//    static let room = "http://127.0.0.1:8080/rest/api/room"
    

}