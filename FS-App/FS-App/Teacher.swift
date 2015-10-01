//
//  File.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 20.08.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import Foundation
import CoreData

class Teacher: NSManagedObject {
    
    @NSManaged var id: String?
    @NSManaged var name: String?
}