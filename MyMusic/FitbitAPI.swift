//
//  FitbitAPI.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 5/6/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class FitbitAPI {
    
    
    static let sharedInstance: FitbitAPI = FitbitAPI()
    
    static let baseAPIURL = URL(string:"https://api.fitbit.com/1")
    
    func authorize(with token: String) {
        let sessionConfiguration = URLSessionConfiguration.default
        var headers = sessionConfiguration.httpAdditionalHeaders ?? [:]
        headers["Authorization"] = "Bearer \(token)"
        sessionConfiguration.httpAdditionalHeaders = headers
        session = URLSession(configuration: sessionConfiguration)
    }
    
    var session: URLSession?
    
    
    
    static func fetchFavActivities(callback: @escaping ([FavActivities]?, Error?)->Void) -> URLSessionDataTask? {
        let path = "/favorite.json"

       
        return fetchFavActivities(for: path) { (favActivities, error) in
            callback(favActivities, error)
        }
    }
    
    
    static func fetchFavActivities(for path: String, callback: @escaping ([FavActivities]?, Error?)->Void) -> URLSessionDataTask? {
        guard let session = FitbitAPI.sharedInstance.session,
            let favActivitiesURL = URL(string: "https://api.fitbit.com/1/user/-/activities"+path) else {
                return nil
        }
        let dataTask = session.dataTask(with: favActivitiesURL) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode < 300 else {
                DispatchQueue.main.async {
                    callback(nil, error)
                }
                return
            }
            
            guard let data = data,
                let dictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [NSDictionary] else {
                    DispatchQueue.main.async {
                        callback(nil, error)
                    }
                    return
            }
            
            let activities:[FavActivities]?
            activities = FavActivities.FacActivitiesArray(dictionaries: dictionary)
            
            DispatchQueue.main.async {
                callback(activities, nil)
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    
    static func fetchDailyActivitySummary(for day: String, callback: @escaping (DailyActivitySummary?, Error?)->Void) -> URLSessionDataTask? {
        guard let session = FitbitAPI.sharedInstance.session,
            let stepURL = URL(string: "https://api.fitbit.com/1/user/-/activities/date\(day)") else {
                return nil
        }
        let dataTask = session.dataTask(with: stepURL) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode < 300 else {
                DispatchQueue.main.async {
                    callback(nil, error)
                }
                return
            }
            
            guard let data = data,
                let dictionarySummary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? NSDictionary else {
                    DispatchQueue.main.async {
                        callback(nil, error)
                    }
                    return
            }
            print(dictionarySummary)
            
            let dailyActivitySummary = DailyActivitySummary.getDailyActivity(dictionary: dictionarySummary)
           
            
            DispatchQueue.main.async {
                callback(dailyActivitySummary, nil)
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    static func deactivateAccount() {
        //FitbitToken
        let userDefaults = UserDefaults.standard
        if let _:AnyObject = userDefaults.object(forKey: "FitbitToken") as AnyObject? {
            userDefaults.removeObject(forKey: "FitbitToken")
                }
    }

}
