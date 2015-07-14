//
//  DetailJobViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 05.07.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class DetailJobViewController: UIViewController {
    
    
    var jobType = String()
    var jobTitle = String()
    var company = String()
    var jobDescription = String()
    var url = String()

    @IBOutlet weak var detailJobTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        var parser = MarkdownParser()
        var completeText = NSMutableAttributedString()
        var attrString = NSAttributedString(string: jobType+"\n\n", attributes: NSDictionary(object: Fonts.normalText, forKey: NSFontAttributeName) as [NSObject : AnyObject])
        completeText.appendAttributedString(attrString)
        attrString = NSAttributedString(string: jobTitle+"\n\n", attributes: NSDictionary(object: Fonts.normalText, forKey: NSFontAttributeName) as [NSObject : AnyObject])
        completeText.appendAttributedString(attrString)
        attrString = NSAttributedString(string: company+"\n\n", attributes: NSDictionary(object: Fonts.normalText, forKey: NSFontAttributeName) as [NSObject : AnyObject])
        completeText.appendAttributedString(attrString)
        completeText.appendAttributedString(parser.calc(jobDescription))
        attrString = NSAttributedString(string: "\n\n" + url, attributes: NSDictionary(object: Fonts.normalText, forKey: NSFontAttributeName) as [NSObject : AnyObject])
        completeText.appendAttributedString(attrString)
        
        
        //String text = "\(jobType)\n\n\(jobTitle)\n\n\(company)\n\n\(parser.calc(jobDescription))\n\n\(url))"
//        super.viewWillAppear(animated)
        detailJobTextView.attributedText = completeText
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
