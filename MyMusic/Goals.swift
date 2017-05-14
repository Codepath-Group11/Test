//
//  Goals.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 5/8/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import Foundation

class Goals {
    
    
    var steps : Int?
    var distance : Int?
    var caloriesOut : Int?
    var floors : Int?
        var activeMinutes : Int?
    
    var dictionary : NSDictionary!
    
    init(dictionary : NSDictionary) {
        
        self.dictionary = dictionary
        steps = dictionary["steps"] as? Int
        distance = dictionary["distance"] as? Int
        floors = dictionary["floors"] as? Int
        caloriesOut = dictionary["caloriesOut"] as? Int
        activeMinutes=dictionary["activeMinutes"] as? Int

    }
    
}
