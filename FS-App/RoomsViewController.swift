//
//  RoomsViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 16.06.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class RoomsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    let tag = "RoomTableViewController"
    let timeAndDayData = [["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag"],["08:15", "10:00", "11:45", "13:30", "15:15", "17:00", "18:45"]]
    
    @IBOutlet weak var tableView: UITableView!
    var rooms: [Room] = [Room]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeAndDayPicker.dataSource = self
        timeAndDayPicker.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        parseRooms("08:15",day: "so")
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
    
    
    
    // TODO: Change from String to url
    
    func parseRooms(time: String, day: String){
        var urlAsString: String = "www.google.de"
        //var xmlURL = NSURL(string: URLs.roomSearch+"\(time)&weekday=\(day)")
        
        let tmp = NSURL(string: urlAsString)
        if let url = tmp {
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            dispatch_async(dispatch_get_global_queue(qos,0)) {() -> Void in
                //if let jsonData: NSData = NSData(contentsOfURL: url){
                if let jsonData: NSData = ExampleData.roomSearch.dataUsingEncoding(NSUTF8StringEncoding) {
                    dispatch_async(dispatch_get_main_queue()){
                        let parser = RoomSearchJSONParser()
                        self.rooms = parser.parse(jsonData)
                        self.tableView.reloadData()
                    }
                }
            }
        }
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
        rooms.removeAll()
        tableView.reloadData()
        
        parseRooms(time, day: day.substringToIndex(advance(day.startIndex, 2)).lowercaseString)
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
        return rooms.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FreeRoom", forIndexPath: indexPath) as! RoomTableViewCell
        cell.freeRoom = rooms[indexPath.row]
        
        return cell
    }
}
