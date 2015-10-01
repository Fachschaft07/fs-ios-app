//
//  NewsDescriptionViewController.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 06.09.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import UIKit

class NewsDescriptionViewController: UIViewController {

    var newsEntry: NewsEntry?
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.text = nil
        if let newsEntry = self.newsEntry {
            let formatter: NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "dd.MM.yy"
            let date: String = formatter.stringFromDate(newsEntry.date)
            let content = newsEntry.content.replaceAll("&#8230;", with: "...")
            let text: String = "\(newsEntry.title)\n\n\(content)\n\n\(newsEntry.url)\n\n\(date)"
            
            descriptionTextView.text = text
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
