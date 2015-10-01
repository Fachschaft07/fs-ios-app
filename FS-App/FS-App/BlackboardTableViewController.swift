//
//  BlackboardTableViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 28.07.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class BlackboardTableViewController: UITableViewController {
    
    @IBOutlet var blackboardTableView: UITableView!
    var entries = [Entry]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blackboardTableView.estimatedRowHeight = blackboardTableView.rowHeight
        blackboardTableView.rowHeight = UITableViewAutomaticDimension
        refresh(super.refreshControl)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return entries.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = blackboardTableView.dequeueReusableCellWithIdentifier("BlackBoardCell", forIndexPath: indexPath) as! BlackboardTableViewCell
        cell.entry = entries[indexPath.row]

        return cell
    }
    
    @IBAction func refresh(sender: UIRefreshControl?) {
        sender?.beginRefreshing()
        let nsurl = NSURL(string: URLs.blackboardEntry)
        if let url = nsurl {
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos,0)) {() -> Void in
                if let jsonData: NSData = NSData(contentsOfURL: url){
                    dispatch_async(dispatch_get_main_queue()){
                        let parser = BlackboardJSONParser()
                        self.entries = parser.parse(jsonData)
                        self.blackboardTableView.reloadData()
                        sender?.endRefreshing()
                    }
                }
            }
        }
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetailBlackboardEntrySegue" {
            if let destination = segue.destinationViewController as? DetailBlackboardViewController {
                if let path = blackboardTableView.indexPathForSelectedRow?.row {
                    destination.entry = entries[path]
                }
            }
        }
    }


}
