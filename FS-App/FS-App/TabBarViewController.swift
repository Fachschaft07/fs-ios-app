//
//  TabBarViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 27.05.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    let tag = "TabBarViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        println(tag)

        // Do any additional setup after loading the view.
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
