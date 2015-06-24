//
//  TestViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 27.05.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, NSXMLParserDelegate {
    
    var rooms = [Room]()
    
    
    
    var roomType: String = ""
    var roomName: String = ""
    var freeUntil: String = ""
    var eName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tmp = "Montag"
        println(tmp.substringToIndex(advance(tmp.startIndex, 2)).lowercaseString)
        
        //http://fs.cs.hm.edu/roomSearch/RESTService/freeRooms?clockTime=10:37&weekday=di
        /*
        
        var xmlURL = NSURL(string: "http://fs.cs.hm.edu/roomSearch/RESTService/freeRooms?clockTime=10:37&weekday=di")
        /*if let url = xmlURL {
            let xmlData = NSData(contentsOfURL: url)
            if xmlData != nil {
                var str = NSString(data: xmlData!, encoding: UInt())
                println(str)
                
            } else { println("nix geht") }
        }*/
        var parser = NSXMLParser(contentsOfURL: xmlURL)!
        parser.delegate = self
        parser.parse()
       
        for r: Room  in rooms {
            println("Art: \(r.roomType), Name: \(r.roomName), Frei bis: \(r.freeUntil)")
        }
        
        /*let request = NSURLRequest(URL: NSURL(string: "http://fs.cs.hm.edu/roomSearch/RESTService/freeRooms?clockTime=10:37&weekday=sa")!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }*/*/
        
    }
    /*
    <auditoriums>
    <room>
    <roomName>R0.005</roomName>
    <freeUntil>22:00</freeUntil>
    </room>
    <room>
    <roomName>R0.006</roomName>
    <freeUntil>22:00</freeUntil>
    </room>
    */
  
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        eName = elementName
        //println(eName)
        switch elementName{
        case "auditoriums": roomType = "Hörsaal"
        case "laboratories": roomType = "Labor"
        case "lounges": roomType = "Aufenthaltsraum"
        default: break
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        let data = string!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        if(!data.isEmpty){
            if eName == "roomName" {
                roomName = data
            } else if eName == "freeUntil" {
                freeUntil = data
            }
        }
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "room" {
            var r = Room(roomType: roomType, roomName: roomName, freeUntil: freeUntil)
            rooms.insert(r, atIndex: 0)
            
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    //var r: Room = Room(roomType: "Labor", roomName: "R1.011", freeUntil: "22:00")
    let rooms: [Room] = [Room(roomType: "Labor", roomName: "R1.011", freeUntil: "22:00"),
    Room(roomType: "Hörsaal", roomName: "R0.012", freeUntil: "22:00"),
    Room(roomType: "Hörsaal", roomName: "R1.011", freeUntil: "22:00"),
    Room(roomType: "Hörsaal", roomName: "R1.010", freeUntil: "22:00")
    ]
    // var y = r.
    for r: Room in rooms{
    println("Typ: \(r.roomType), Name: \(r.roomName), freeUntil: \(r.freeUntil)")
    }
    // Do any additional setup after loading the view.

    */
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
