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
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    var spotifyService = SpotifyService()

    
    class func getUserPlayLists(userId:String,musicServiceType:String,success:@escaping([SimplifiedPlaylist]) -> (),failure:@escaping (Error) ->()) {
        
        //TODO: Use factory pattern based on musicServiceType as we add more services.

        _ = Spartan.getMyPlaylists(success: { (PagingObject) in
            
            let simplifiedPlayLists = PagingObject.items as [SimplifiedPlaylist]
            success(simplifiedPlayLists)
            
        }, failure: { (error:SpartanError) in
            print((error.errorMessage))
        })
        
    }
    
    
    func deactivateAccount(musicServiceType:String){
        
        let userDefaults = UserDefaults.standard
        if let _:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            userDefaults.removeObject(forKey: "SpotifySession")
            Spartan.authorizationToken = nil
        }
        
    }
    
    }
    


