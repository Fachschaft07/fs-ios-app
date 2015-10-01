//
//  MainTableViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 29.09.15.
//  Copyright © 2015 Fachschaft07. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    @IBOutlet weak var versionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLesson()
        if let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text = "Version \(version)"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lessonNameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var suffixLabel: UILabel!
    
    private func loadLesson(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let database: DatabaseConnector = DatabaseConnector(context: context!)
        let time = getTime()
//        print(time.hour)
        let lesson = database.getLesson(time.day, hour: time.hour)
        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        timeLabel.text = "\(formatter.stringFromNumber(Int(lesson.hour!)!)!):\(formatter.stringFromNumber(Int(lesson.minute!)!)!)"
        lessonNameLabel.text = lesson.moduleName!
        roomLabel.text = lesson.room!
        
        teacherLabel.text = database.getTeacher(lesson.teacherID!)?.name ?? ""
        
        suffixLabel.text = lesson.suffix!
        
    }
    
    private func getTime() -> (day: String, hour: String){
        
        let date = NSDate()
    
        let calendar = NSCalendar.currentCalendar()
        var components = calendar.components(.Weekday, fromDate: date)
        var day = components.weekday
        components = calendar.components(.Hour, fromDate: date)
        let hour = components.hour
//        print(hour)
        components = calendar.components(.Minute, fromDate: date)
        let minute = components.minute
//        print(minute)
        let weekdays = ["Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Sammstag"]
        let finalDay: String
        if day == 1 || day == 7{
            day = 2
        }
        
        if hour == 20 || (hour > 20 && minute > 15){
            if day != 6 {
                finalDay = weekdays[day]
            } else {
                finalDay = weekdays[2]
            }
        } else {
            finalDay = weekdays[day-1]
        }
        
        return (day: finalDay, hour: getHourforLesson(hour, minute: minute))
    }
    
    private func getHourforLesson(hour: Int, minute: Int) -> String {
        var hourForLesson = "8"
        if hour >= 8 {
            if hour == 9 && minute > 45 {
                hourForLesson = "10"
            } else if hour == 10 {
                hourForLesson = "10"
            } else if (hour == 11 && minute > 30) || hour == 12 {
                hourForLesson = "11"
            } else if (hour == 13 && minute > 15) || hour == 14 {
                hourForLesson = "13"
            } else if hour == 15 || (hour == 16 && minute <= 45){
                hourForLesson = "15"
            } else if (hour == 16 && minute > 45) || hour == 17 || (hour == 18 && minute <= 30){
                hourForLesson = "17"
            } else if (hour == 18 && minute > 30) || hour == 19 || (hour == 20 && minute <= 15){
                hourForLesson = "18"
            } else {
                hourForLesson = "8"
            }
        }
        
        
        return hourForLesson
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
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
