//
//  Client.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 4/27/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

import BDBOAuth1Manager
import Spartan

class MusicClient:NSObject{
    
    var simplifiedPlayLists:[SimplifiedPlaylist] = []
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    var spotifyService = SpotifyService()

    
    public func getUserPlayLists(userId:String,musicServiceType:String,success:@escaping([SimplifiedPlaylist]) -> (),failure:@escaping (Error) ->()) {
        
        //TODO: Use factory pattern based on musicServiceType as we add more services.
        
        // spotifyService.getUserPlayLists(userId: " ", success: <#T##([SimplifiedPlaylist]) -> ()#>, failure: <#T##(Error) -> ()#>)
        
        _ = Spartan.getUsersPlaylists(userId: "onlynaresh", limit: 20, offset: 0, success: { (pagingObject) in
            // Get the playlists via pagingObject.playlists
            self.simplifiedPlayLists = pagingObject.items as [SimplifiedPlaylist]
            success(self.simplifiedPlayLists)
        }, failure: { (error) in
            print(error)
        })
        
    }
    
    
    func deactivateAccount(musicServiceType:String){
        
        let userDefaults = UserDefaults.standard
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            userDefaults.removeObject(forKey: "SpotifySession")
            Spartan.authorizationToken = nil
        }
        
    }
    
    }
    


