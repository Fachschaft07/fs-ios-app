//
//  RoomTableViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 27.05.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class RoomTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, NSXMLParserDelegate {
    let tag = "RoomTableViewController"
    let timeAndDayData = [["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag"],["08:15", "10:00", "11:45", "13:30", "15:15", "17:00", "18:45"]]
    
    var freeRooms = [Room]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeAndDayPicker.dataSource = self
        timeAndDayPicker.delegate = self
        
        freeRooms = initRooms("08:15",day: "so")
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    var rooms: [Room] = [Room]()
    func initRooms(time: String, day: String) -> [Room]{
        
        var xmlURL = NSURL(string: "http://fs.cs.hm.edu/roomSearch/RESTService/freeRooms?clockTime="+time+"&weekday="+day)
        
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
        
        freeRooms = initRooms(time, day: day.substringToIndex(advance(day.startIndex, 2)).lowercaseString)
        //freeRooms = getRooms()
        tableView.reloadData()
        
        
        println("day: \(day) - time: \(time)")
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return freeRooms.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FreeRoom", forIndexPath: indexPath) as! RoomTableViewCell
        cell.freeRoom = freeRooms[indexPath.row]
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
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
