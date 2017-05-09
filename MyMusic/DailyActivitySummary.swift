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
//        activityId = dictionary["activityId"] as? Int
//        description = dictionary["description"] as? String
//        mets = dictionary["mets"] as? Int
//        activityName = dictionary["name"] as? String
    }
    

    
    static func getDailyActivity(dictionary: NSDictionary) -> DailyActivitySummary {
        return  DailyActivitySummary(dictionary: dictionary)
    }
    
    
}
