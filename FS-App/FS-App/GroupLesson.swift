//
//  GroupLesson.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 29.09.15.
//  Copyright © 2015 Fachschaft07. All rights reserved.
//

import Foundation

struct GroupLesson {
    let letter: String
    let semester: String
    let study: String
    
    let moduleID: String
    let moduleName: String
    
    let teacherID: String
    let teacherName: String
    
    let groups: [Int]
}