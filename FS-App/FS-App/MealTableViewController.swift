//
//  MealTableViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 06.09.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    @IBOutlet var mealTableView: UITableView!
    var meals: [[Meal]] = [[Meal]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealTableView.estimatedRowHeight = mealTableView.rowHeight
        mealTableView.rowHeight = UITableViewAutomaticDimension
        loadMeals()
    }
    
    func loadMeals(){
        let nsurl = NSURL(string: URLs.meal)
        if let url = nsurl {
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos,0)) {() -> Void in
                if let jsonData: NSData = NSData(contentsOfURL: url){
                    dispatch_async(dispatch_get_main_queue()){
                        let parser = MealsJSONParser()
                        self.meals = parser.parse(jsonData)
                        self.mealTableView.reloadData()
                    }
                } else {
                    let refreshAlert = UIAlertController(title: "Keine Verbindung", message: "Leider konnte keine Verbindung zur Schnittstelle hergestellt werden. Versuchen Sie es bitte später erneut.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                    }))
                    
                    self.presentViewController(refreshAlert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return meals.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return meals[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MealCell", forIndexPath: indexPath) as! MealTableViewCell
        cell.meal = meals[indexPath.section][indexPath.row]
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       // let sectionName = meals[section][0].date.description
        let formatter = NSDateFormatter();
        formatter.dateFormat = "dd.MM.yyyy";
        let date = formatter.stringFromDate(meals[section][0].date);
        //let name = sectionName
        return date
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

}
