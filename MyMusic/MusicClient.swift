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

class MusicClient: NSObject{
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    private static var service = SpotifyService()
    
    class func player() -> SPTAudioStreamingController{
        return service.player!
    }
    
    class func getLoginURL()->URL{
        return service.loginUrl!
    }
    
    class func authorization()-> SPTAuth {
        return service.auth
    }
    
    class func configuSpotifyService() {
        service.configSpotify()
    }
    
    class func handleSpotifyURL(url: URL) -> Bool {
        return service.handleURL(url: url)
    }
    
    class func checkCurrentSession() -> Bool {
        return service.checkUserSessionExist()
    }
    
    private class func getPlaylistID(query: String, success: @escaping (String)->(), failure: (Error)->()){
        _ = Spartan.search(query: query, type: .playlist, success: { (PagingObject) in
            let playlistID = PagingObject.items[0].id
            success(playlistID!)
        }, failure: { (error:SpartanError) in
            print(error.errorMessage)
        })
    }
    
    class func searchForPlaylist(queryTitle: String, success: @escaping ([PlaylistTrack])->(), failure: (Error)->()){
        
        MusicClient.getPlaylistID(query: queryTitle, success: { (ID:String) in
            _ = Spartan.getPlaylistTracks(userId: "spotify", playlistId: ID, success: { (PagingObject) in
                
                success(PagingObject.items)
                
            }, failure: { (error:SpartanError) in
                print(error.errorMessage)
            })
            
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    class func getUserPlayLists(userId:String,musicServiceType:String,success:@escaping([SimplifiedPlaylist]) -> (),failure:@escaping (Error) ->()) {
        
        //TODO: Use factory pattern based on musicServiceType as we add more services.
        
        _ = Spartan.getMyPlaylists(success: { (PagingObject) in
            
            success(PagingObject.items)
            
        }, failure: { (error:SpartanError) in
            print((error.errorMessage))
        })
        
    }
    
    
    
    
}



