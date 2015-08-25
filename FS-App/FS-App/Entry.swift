//
//  Entry.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 28.07.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import Foundation


struct Entry {
    let id: String
    let author: Person
    let subject: String
    let text: String
    let teachers: [Person]
    let groups: [Group]
    let publish: Double
    let url: String
}