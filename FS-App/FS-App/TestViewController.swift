//
//  TestViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 27.05.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class TestViewController: UIViewController{
    
    override func viewDidLoad() {
        navigationController?.navigationBar.tintColor = UIColor.redColor()
        
        let url = NSURL(string: "http://127.0.0.1:8080/rest/api/job")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            //println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
    }
}
