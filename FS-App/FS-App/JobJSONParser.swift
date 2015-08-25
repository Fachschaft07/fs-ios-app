//
//  JobJSONParser.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 01.07.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import Foundation

class JobJSONParser{
    
    
    private var jobs: [Job] = [Job]()
    
    func parse(data: NSData) ->[Job]{
        jobs.removeAll()
        
        var error: NSError?
        
        let jsonResult:NSArray = (NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers , error: &error) as? NSArray)!
        if((error) != nil) {
            // If there is an error parsing JSON, print it to the console
            println("JSON Error \(error!.localizedDescription)")
        }
        
        for currentJob in jsonResult{
            
            var title: String = currentJob.valueForKey("title") as! String
            
            
            var company: String = currentJob.valueForKey("provider") as! String
            var description: String = currentJob.valueForKey("description") as! String
            var contactData: NSDictionary = currentJob.valueForKey("contact") as! NSDictionary
            
            
            
            var contact: Person
            
            if contactData.count > 0 {
                var id: String = contactData.valueForKey("id") as! String
                var lastName: String = contactData.valueForKey("lastName") as! String
                var firstName: String = contactData.valueForKey("firstName") as! String
                var title: String = contactData.valueForKey("title") as! String
                
                contact = Person(id: id,lastName: lastName, firstName: firstName, title: title)
            } else {
                contact = Person(id: "",lastName:"",firstName:"", title:"")
            }
           
            let tmp = Job(title: title, provider: company, description: description, contact: contact)
            jobs.append(tmp)
        }
        return jobs
    }
}

/*
"id": "nischwitzalfred",
"lastName": "Nischwitz",
"firstName": "Alfred",
"title": "Prof. Dr."
*/


/*

let type: String
let title: String
let company: String
let description: String
let url: String

{
"title": "Abschlussarbeit: Deployment and Release of an Open Source Software",
"provider": "VIRES Simulationstechnologie GmbH",
"description": "*Bachelor's Thesis*\n#Within the scope of this thesis, the student shall deploy and release the source of an already\ndeveloped software for validating the file format OpenDRIVE (opendrive.org). This includes\nthe definition of validation rules for OpenDRIVE, the testing of the software for different\nstandards of OpenDRIVE, the clearification of the licensing and any other task for the proper\ndeployment and release of the software.\nIt is also possible to finish this work during an internship.\n\n#*Master's Thesis*\n#In addition to the above mentioned work, the software shall be analyzed for refactoring and\nthe implementation of missing features. This could include a preview visualization of the road\nnetwork defined by OpenDRIVE, for example.\nIt is also possible to finish this work as a student trainee within one year.\n\n\n#*Your Profile*\n.Student of Information Systems and Management or Computer Science\n.Intermediate knowledge in Java\n.Experience with Apache Maven is a benefit .\n\n#*Company*\n#VIRES - a products and services company – has its main fields of operation in the automotive\nand railroad industries. In the automotive market, VIRES provides simulation solutions for the\ndevelopment, validation and presentation of driver assistance and active safety systems.\nAdditionally, VIRES is a main contributor and partner in the following standardization projects\nin the automotive industry: OpenDRIVE, OpenCRG and OpenSCENARIO.\nIf you are interested in this work, please send us a short application and we can discuss\nfurther steps.\n\n#*Contact*\n#VIRES Simulationstechnologie GmbH\n#Grassinger Straße 8\n#83043 Bad Aibling\n#Phone: +49 8061 / 939093-21\n#e-mail: daniel.wiesenhuetter@vires.com",
"program": null,
"contact": "nischwitzalfred",
"expire": 1439244000000,
"url": "http://www.vires.com",3
"id": "abschlussarbeitdeploymentandreleaseofanopensourcesoftwareviressimulationstechnologiegmbh"
},

*/