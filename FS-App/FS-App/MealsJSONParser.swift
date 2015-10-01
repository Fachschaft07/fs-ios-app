//
//  MealsJSONParser.swift
//  FS-App
//
//  Created by Benjamin Reischboeck on 07.09.15.
//  Copyright (c) 2015 Fachschaft07. All rights reserved.
//

import Foundation

class MealsJSONParser {
    
    func parse(data: NSData) -> [[Meal]] {
        var meals = [[Meal]]()
        
        let jsonResult: NSArray = ((try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSArray)
        
        
        
        var mealDictionary: Dictionary<Double, [Meal]> = Dictionary()
        
        for currentMeal in jsonResult {
            //Meal bauen
            let dateAsDouble = currentMeal.valueForKey("date") as! Double
            let date: NSDate = NSDate(timeIntervalSince1970: dateAsDouble/1000)
            let meal = Meal(name: currentMeal.valueForKey("name") as! String, type: currentMeal.valueForKey("type") as! String, date: date)
            //testen ob timestamp schon drin
            
            if var array = mealDictionary[dateAsDouble] {
                array.append(meal)
                mealDictionary.removeValueForKey(dateAsDouble)
                mealDictionary[dateAsDouble] = array
            } else {
                mealDictionary[dateAsDouble] = [meal]
            }
        }
        
            
        for mealArray in mealDictionary.values {
            meals.append(mealArray)
        }
        return meals.sort {$0[0].date.compare($1[0].date) == NSComparisonResult.OrderedAscending}
    }
}