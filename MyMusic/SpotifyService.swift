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
    
    var session:SPTSession!
    var player: SPTAudioStreamingController?
    
    var auth: SPTAuth{
      return SPTAuth.defaultInstance()!
    }
    var loginUrl: URL?{
        return auth.spotifyWebAuthenticationURL()
    }
    
    override init(){
        super.init()
        // insert redirect your url and client ID below
        let redirectURL = "mymusicdemo://returnAfterLogin"
    
        auth.redirectURL = URL(string: redirectURL)
        auth.clientID = "277edce5ad1741fa8f29c73eec3a132c"
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        
        createUserSession()
        
        initializePlayer(authSession: session)
    }
    
    func createUserSession () {
        
        if let sessionObj:AnyObject = UserDefaults.standard.object(forKey: "SpotifySession") as AnyObject? {
            
            let sessionDataObj = sessionObj as! Data
            let userSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj)
            session = userSession as! SPTSession
            
            Spartan.authorizationToken = session.accessToken
        }
        
    }
    
    func deactivateAccount(){
        
        let userDefaults = UserDefaults.standard
        if let _:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            userDefaults.removeObject(forKey: "SpotifySession")
            Spartan.authorizationToken = nil
        }
        
    }
    
    func getLoginUrl()-> URL{
        return loginUrl!
    }
    
    func getSession()->SPTSession{
        
        return session
    }
    
    func initializePlayer(authSession:SPTSession){
        
        if player == nil {
            
            player = SPTAudioStreamingController.sharedInstance()
            player?.playbackDelegate = self
            player?.delegate = self
            try! player?.start(withClientId: auth.clientID)
            player?.login(withAccessToken: authSession.accessToken)
        }
        
    }
    
}
