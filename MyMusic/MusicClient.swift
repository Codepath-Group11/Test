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
    private static var service = SpotifyService()
    
    class func player() -> SPTAudioStreamingController{
        return service.player!
    }
    
    class func getLoginURL()->URL{
        return service.loginUrl!
    }
    
    class func authorization()->SPTAuth{
        return service.auth
    }
    
    class func getUserPlayLists(userId:String,musicServiceType:String,success:@escaping([SimplifiedPlaylist]) -> (),failure:@escaping (Error) ->()) {
        
        //TODO: Use factory pattern based on musicServiceType as we add more services.

        _ = Spartan.getMyPlaylists(success: { (PagingObject) in
            
            let simplifiedPlayLists = PagingObject.items as [SimplifiedPlaylist]
            success(simplifiedPlayLists)
            
        }, failure: { (error:SpartanError) in
            print((error.errorMessage))
        })
        
    }
    
    
    
    
}
    


