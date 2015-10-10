//
//  TimetableViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 25.08.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit
import CoreData

enum days: String {
    case Mo = "Mo"
    case Di = "Di"
    case Mi = "Mi"
    case Do = "Do"
    case Fr = "Fr"
    
    var fullDay: String {
        get{
            switch(self) {
            case Mo:
                return "Montag"
            case Di:
                return "Dienstag"
            case Mi:
                return "Mittwoch"
            case Do:
                return "Donnerstag"
            case Fr:
                return "Freitag"
            }
        }
    }
    
    
}


class TimetableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var context: NSManagedObjectContext!
    var databaseConnector: DatabaseConnector?
    var lessons: [Lesson] = [Lesson]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDelegate.managedObjectContext
        databaseConnector = DatabaseConnector(context: context)
        
        
        loadTable("Montag")

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func changeDay(sender: UISegmentedControl) {
        let day = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        let completeDay = days(rawValue: day!)?.fullDay
        loadTable(completeDay!)
    }
    
    func loadTable(day: String) {
        lessons = databaseConnector!.getLessonsForDay(day)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return lessons.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimetableTableViewCell", forIndexPath: indexPath) as! TimetableTableViewCell
        cell.lesson = lessons[indexPath.row]
        
        return cell
    }

    @IBAction func clearTimeTable(sender: AnyObject) {
        let refreshAlert = UIAlertController(title: "Stundenplan zurücksetzen", message: "Achtung alle eingetragenen Stunden werden aus dem Stundenplan gelöscht.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: { (action: UIAlertAction!) in
            self.databaseConnector?.clearLessons()
            self.tableView.reloadData()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
