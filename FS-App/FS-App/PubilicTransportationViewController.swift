//
//  PubilicTransportationViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 28.06.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class PubilicTransportationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tag = "PublicTransportViewController"
    
    @IBOutlet weak var publicTransportTableView: UITableView!
    
    var publicTransport: [PublicTransport] = [PublicTransport]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        publicTransportTableView.delegate = self
        publicTransportTableView.dataSource = self
        loadTable(URLs.loth)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
        Reload the table if the user changes the
    */
    @IBAction func changeStation(sender: UISegmentedControl) {
        var name = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)!
        let url: String
        if name.hasPrefix("Loth")   {
            url = URLs.loth
        } else {
            url = URLs.pasing
        }
        loadTable(url)
    }
    
    /*
        Gets the data from the server and fills the tableView.
        Its important to dispach the urlRequest to another queue. (NEVER BLOCK THE MAIN QUEUE!!!)
    */
    func loadTable(urlAsString: String) {
        let tmp = NSURL(string: urlAsString)
        if let url = tmp {
            let qos = Int(QOS_CLASS_USER_INITIATED.value)
            dispatch_async(dispatch_get_global_queue(qos,0)) {() -> Void in
                if let jsonData: NSData = NSData(contentsOfURL: url){
                    dispatch_async(dispatch_get_main_queue()){
                        let parser = PublicTransportJSONParser()
                        self.publicTransport = parser.parse(jsonData)
                        self.publicTransportTableView.reloadData()
                        
                    }
                }
            }
        }
    }
    
    // Mark: - Table view data source
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publicTransport.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = publicTransportTableView.dequeueReusableCellWithIdentifier("PublicTransportCell", forIndexPath: indexPath) as! PublicTransportTableViewCell
        cell.publicTransport = publicTransport[indexPath.row]
        return cell
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
