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
    var mets : Int?
    var activityName : String?
    var steps: String?
    var startTime:Date?
    var name:String?
    var isFavourite:Bool?
    var calories:Int?
    
    
    var dictionary : NSDictionary!
    
    init(dictionary : NSDictionary) {
        
        self.dictionary = dictionary
        activityId = dictionary["activityId"] as? Int
        description = dictionary["description"] as? String
        mets = dictionary["mets"] as? Int
        activityName = dictionary["name"] as? String
    }
    
    static func FacActivitiesArray(dictionaries: [NSDictionary]) -> [FavActivities] {
        return dictionaries.map { FavActivities(dictionary: $0) }
    }
}
