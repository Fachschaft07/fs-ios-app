//
//  AddLessonViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 28.08.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class AddLessonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var addLessonTableView: UITableView!
    
    private var groupLessons: [GroupLesson] = [GroupLesson]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addLessonTableView.delegate = self
        addLessonTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var groupTextField: UITextField!
    func checkInput(input: String) -> Bool {
        let pattern: String = "^((i(b|c|f|g|n|s))|go)[1-7]?(a|b|c)?$"
        if input.rangeOfString(pattern, options: .RegularExpressionSearch) != nil {
            return true
        }
        return false
    }
    @IBAction func startSearch(sender: AnyObject) {
        let group = groupTextField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) ?? ""
        //check input
        if checkInput(group.lowercaseString){
            let url = "\(URLs.timeTableGroup)\(group)"
            let tmp = NSURL(string: url)
            groupTextField.resignFirstResponder()
            if let url = tmp {
                let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
                dispatch_async(dispatch_get_global_queue(qos,0)) {() -> Void in
                    if let jsonData: NSData = NSData(contentsOfURL: url){
                        dispatch_async(dispatch_get_main_queue()){
                            let parser = TimeTableGroupJSONParser()
                            self.groupLessons = parser.parse(jsonData)
                            if self.groupLessons.count == 0 {
                                let refreshAlert = UIAlertController(title: "Studiengruppe nicht gefunden", message: "Die eingegebene Studiengruppe \(group) wurde nicht gefunden.", preferredStyle: UIAlertControllerStyle.Alert)
                                
                                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                                    self.groupTextField.text = ""
                                }))
                                
                                self.presentViewController(refreshAlert, animated: true, completion: nil)

                            }
                            self.addLessonTableView.reloadData()
                            //display groups on TableView
                            //print(self.groupLessons)
                        }
                    } else {
                        dispatch_async(dispatch_get_main_queue()){
                            
                            let refreshAlert = UIAlertController(title: "Keine Verbindung", message: "Leider konnte keine Verbindung zur Schnittstelle hergestellt werden. Versuchen Sie es bitte später erneut.", preferredStyle: UIAlertControllerStyle.Alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                            }))
                            
                            self.presentViewController(refreshAlert, animated: true, completion: nil)
                        }
                    }
                }
                
            }
        } else {
            let refreshAlert = UIAlertController(title: "Falsches Format", message: "Die Studiengruppe muss folgendermaßen angegeben werden:\n-Studiengang(IF)\n-Semester(1)\n-Gruppe(a)\n=> IF1a.", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                self.groupTextField.text = ""
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
        }
    }
    
    // Mark: - Table view data source
    
    
   
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupLessons.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = addLessonTableView.dequeueReusableCellWithIdentifier("AddLessonCell", forIndexPath: indexPath) as! AddLessonTableViewCell
        cell.lesson = groupLessons[indexPath.row]
        //print(groupLessons[indexPath.row].teacherName)
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
