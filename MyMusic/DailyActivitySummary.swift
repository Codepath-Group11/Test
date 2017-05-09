//
//  DailyActivitySummary.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 5/8/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import Foundation

class DailyActivitySummary:NSObject {
    
    var activityId : Int?
    var activityDescription : String?
    var mets : Int?
    var activityName : String?
    
    var activities:[Activity]?
    var goals:Goals?
    
    var dictionary : NSDictionary!
    
    init(dictionary : NSDictionary) {
        
        self.dictionary = dictionary

        let goalsDict = dictionary["goals"] as? NSDictionary

        if let goalsDict = goalsDict {
            goals = Goals(dictionary: goalsDict)
        }
        
        let activityDictionary:[NSDictionary]
        
        activityDictionary = (dictionary["activities"] as? [NSDictionary])!
   
        activities = Activity.getActivities(dictionaries: activityDictionary)
        
    }
    

    
    static func getDailyActivity(dictionary: NSDictionary) -> DailyActivitySummary {
        return  DailyActivitySummary(dictionary: dictionary)
    }
    
    
}
