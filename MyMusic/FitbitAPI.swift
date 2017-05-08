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

       
        return fetchActivities(for: path) { (favActivities, error) in
            callback(favActivities, error)
        }
    }
    
    
    static func fetchActivities(for path: String, callback: @escaping ([FavActivities]?, Error?)->Void) -> URLSessionDataTask? {
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

}
