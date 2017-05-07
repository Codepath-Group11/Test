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
    
    var session: SPTSession! {
        didSet {
            initializePlayer(authSession: session)
        }
    }
    
    var player: SPTAudioStreamingController?
    
    var auth: SPTAuth {
        return SPTAuth.defaultInstance()!
    }
    
    var loginUrl: URL?{
        return auth.spotifyWebAuthenticationURL()
    }
    
    var user: SPTUser?
    
    override init(){
        super.init()
        // insert redirect your url and client ID below
    }
    
    func configSpotify() {
        let redirectURL = "mymusicdemo://returnAfterLogin"
        auth.redirectURL = URL(string: redirectURL)
        auth.clientID =   "277edce5ad1741fa8f29c73eec3a132c"
        auth.sessionUserDefaultsKey = "current session"
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
    }
    
    func checkUserSessionExist () -> Bool  {
        if let sessionData = UserDefaults.standard.object(forKey: "SpotifySession") as? Data {
            let userSession = NSKeyedUnarchiver.unarchiveObject(with: sessionData)
            if let session = userSession as? SPTSession {
                if session.isValid() {
                    self.session = session
                    Spartan.authorizationToken = session.accessToken
                    print ("get valid session from user default")
                    return true
                } else {
                    print("Invalid session save in user default")
                    deactivateAccount()
                    return false
                }
            } else {
                deactivateAccount()
                return false
            }
        }
        return false
    }
    
    func handleURL(url: URL) -> Bool {
        let value = auth.canHandle(url)
        if value {
            oauth(with: url)
        }
        return value
    }
    
    //This func shouldn't call after an valid session is exist
    func currentUser (completion: @escaping ((SPTUser?) ->())) {
        SPTUser.requestCurrentUser(withAccessToken: session.accessToken , callback: { (error, data) in
            if ((error) != nil) {
                completion(nil)
            } else {
                if let user = data as? SPTUser  {
                    print("Couldn't cast as SPTUser");
                    let userId = user.canonicalUserName
                    print(userId!)
                } else {
                    completion(nil)
                }
            }
        })
    }
    
    func oauth(with url: URL) {
        auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error, session) in
            if error != nil {
                print("error! when auth with spotify")
            } else {
                let userDefaults = UserDefaults.standard
                if let session = session {
                    let sessionData: NSData = NSKeyedArchiver.archivedData(withRootObject: session) as NSData
                    if sessionData.length > 0 {
                        userDefaults.set(sessionData, forKey: "SpotifySession")
                        userDefaults.synchronize()
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "loginSuccessfull"), object: nil)
                    } else {
                        userDefaults.removeObject(forKey: "SpotifySession")
                    }
                }
            }
        })
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
            let value = try! player?.start(withClientId: auth.clientID)
            print("player start? \(value)")
            player?.login(withAccessToken: authSession.accessToken)
        }
    }
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
            print("player did log in")
    }
}
