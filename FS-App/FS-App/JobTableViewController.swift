//
//  JobTableViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 01.07.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class JobTableViewController: UITableViewController {

    @IBOutlet weak var jobTableView: UITableView!
    
    var jobs: [Job] = [Job]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobTableView.estimatedRowHeight = jobTableView.rowHeight
        jobTableView.rowHeight = UITableViewAutomaticDimension
        loadJobs()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func refresh(sender: UIRefreshControl?) {
        sender?.beginRefreshing()
        let nsurl = NSURL(string: URLs.job)
        if let url = nsurl {
            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
            dispatch_async(dispatch_get_global_queue(qos,0)) {() -> Void in
                if let jsonData: NSData = NSData(contentsOfURL: url){
                    dispatch_async(dispatch_get_main_queue()){
                        let parser = JobJSONParser()
                        self.jobs = parser.parse(jsonData)
                        self.jobTableView.reloadData()
                        sender?.endRefreshing()
                    }
                }
            }
        }

    }
    
    func loadJobs() {
        refresh(refreshControl)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = jobTableView.dequeueReusableCellWithIdentifier("JobCell", forIndexPath: indexPath) as! JobTableViewCell
        cell.job = jobs[indexPath.row]
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetailJobSeque" {
            if let destination = segue.destinationViewController as? DetailJobViewController {
                if let jobIndex = jobTableView.indexPathForSelectedRow?.row {
                    destination.jobTitle = jobs[jobIndex].title
                    destination.jobDescription = jobs[jobIndex].description
                    destination.company = jobs[jobIndex].provider
                    destination.contact = jobs[jobIndex].contact
                }
            }
        }
    }
    

}
