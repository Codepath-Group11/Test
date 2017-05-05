//
//  SpotifyService.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 4/29/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import Foundation
import Spartan
import SafariServices

class SpotifyService: NSObject, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {
    
    static var auth = SPTAuth.defaultInstance()!
    static var player: SPTAudioStreamingController?
    
    var session:SPTSession!
    var loginUrl: URL?
    
    override init(){
        // insert redirect your url and client ID below
        let redirectURL = "mymusicdemo://returnAfterLogin"
        SpotifyService.auth.redirectURL = URL(string: redirectURL)
        SpotifyService.auth.clientID = "277edce5ad1741fa8f29c73eec3a132c"
        SpotifyService.auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = SpotifyService.auth.spotifyWebAuthenticationURL()
    }
    
    func createUserSession () {
        
        if let sessionObj:AnyObject = UserDefaults.standard.object(forKey: "SpotifySession") as AnyObject? {
            
            let sessionDataObj = sessionObj as! Data
            let userSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            
            self.session = userSession
            
            Spartan.authorizationToken = self.session.accessToken
            
            initializaPlayer(authSession: session)
        }
        
    }
    
    func initializaPlayer(authSession:SPTSession){
        
        if SpotifyService.player == nil {
            
            
            SpotifyService.player = SPTAudioStreamingController.sharedInstance()
            SpotifyService.player!.playbackDelegate = self
            SpotifyService.player!.delegate = self
            try! SpotifyService.player?.start(withClientId: SpotifyService.auth.clientID)
            SpotifyService.player!.login(withAccessToken: authSession.accessToken)
        }
        
    }

    //var musicClient = MusicClient()
//    
// func getUserPlayLists(userId:String,success:@escaping([SimplifiedPlaylist]) -> (),failure:@escaping (Error) ->()) {
//    
//    // Add user id here to pull the play lists.
//    _ = Spartan.getUsersPlaylists(userId: "", limit: 20, offset: 0, success: { (pagingObject) in
//        
//        // Get the playlists via pagingObject.playlists
//        self.simplifiedPlayLists = pagingObject.items as [SimplifiedPlaylist]
//        success(self.simplifiedPlayLists)
//        
//    }, failure: { (error) in
//        print(error)
//    })
//    // musicClient.getUserPlayLists(userId:userId,musicServiceType:"",success:success,failure:failure)
//    }

    
  
    
}
