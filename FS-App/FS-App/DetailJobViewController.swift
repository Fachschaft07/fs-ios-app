//
//  DetailJobViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 05.07.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class DetailJobViewController: UIViewController {
    
    
    var jobTitle: String = ""
    var company: String  = ""
    var jobDescription: String = ""
    var contact: Person = Person(id: "", lastName: "", firstName: "", title: "")

    @IBOutlet weak var detailJobTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var text: String = "\(jobTitle)\n\n\(company)\n\n\(jobDescription)\n\n\(contact.title)\n\(contact.lastName)\n\(contact.firstName)"
        detailJobTextView.text = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
