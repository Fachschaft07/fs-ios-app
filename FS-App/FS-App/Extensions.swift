//
//  Extensions.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 06.09.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import Foundation

extension String {
    /** func to check if a string contains the given string */
    func contains(find: String) -> Bool{
        return self.rangeOfString(find) != nil
    }

    func replaceAll(replace: String, with: String) -> String {
        return self.stringByReplacingOccurrencesOfString(replace, withString: with)
    }
}

