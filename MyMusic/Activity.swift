//
//  activities.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 5/8/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import Foundation

class Activity {
    
    var activityId : Int?
    var description : String?
    var activityName : String?
    var steps: String?
    var startTime:Date?
    var name:String?
    var isFavourite:Bool?
    var calories:Int?
    var activityParentId:Int?
    
    var dictionary : NSDictionary!
    
    init(dictionary : NSDictionary) {
        
        self.dictionary = dictionary
        activityId = dictionary["activityId"] as? Int
        activityParentId = dictionary["activityParentId"] as? Int
        calories = dictionary["calories"] as? Int
        isFavourite = dictionary["isFavorite"] as? Bool

        description = dictionary["description"] as? String
        activityName = dictionary["name"] as? String
        
    }
    
    static func getActivities(dictionaries: [NSDictionary]) -> [Activity] {
        return dictionaries.map { Activity(dictionary: $0) }
    }
    

}
