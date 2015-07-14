//
//  RoomsViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 16.06.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class RoomsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, NSXMLParserDelegate {
    let tag = "RoomTableViewController"
    let timeAndDayData = [["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag"],["08:15", "10:00", "11:45", "13:30", "15:15", "17:00", "18:45"]]
    
    @IBOutlet weak var tableView: UITableView!
    var freeRooms = [Room]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeAndDayPicker.dataSource = self
        timeAndDayPicker.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        freeRooms = parseRooms("08:15",day: "so")
        buildTitle()
       
    }
    
    
    private func buildTitle(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "roomsearch_holo_light")
        imageView.image = image
        navigationItem.titleView = imageView
        navigationItem.rightBarButtonItem?.title = "Raumsuche"
       

    }
    
    //temporary array to save the parsed rooms.
    var rooms: [Room] = [Room]()
    
    func parseRooms(time: String, day: String) -> [Room]{
        
        var xmlURL = NSURL(string: URLs.roomSearch+"\(time)&weekday=\(day)")
        
        var parser = NSXMLParser(contentsOfURL: xmlURL)!
        parser.delegate = self
        parser.parse()
        
        return rooms
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - TableViewHeader
    
    @IBOutlet weak var timeAndDayPicker: UIPickerView!
    
    @IBAction func searchForFreeRooms(sender: AnyObject) {
        var day = pickerView(timeAndDayPicker, titleForRow: timeAndDayPicker.selectedRowInComponent(0), forComponent: 0)
        var time = pickerView(timeAndDayPicker, titleForRow: timeAndDayPicker.selectedRowInComponent(1), forComponent: 1)
        freeRooms.removeAll()
        rooms.removeAll()
        tableView.reloadData()
        
        freeRooms = parseRooms(time, day: day.substringToIndex(advance(day.startIndex, 2)).lowercaseString)
        tableView.reloadData()
        
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return timeAndDayData.count
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeAndDayData[component].count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return timeAndDayData[component][row]
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return freeRooms.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FreeRoom", forIndexPath: indexPath) as! RoomTableViewCell
        cell.freeRoom = freeRooms[indexPath.row]
        
        return cell
    }
    
    // MARK: - XMLParser Delegate
    var eName = ""
    var roomType = ""
    var roomName = ""
    var freeUntil = ""
    
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
    
    
    
}
