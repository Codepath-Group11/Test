//
//  ViewController.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 4/25/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation
import Spartan


class ViewController: UIViewController, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {

    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession!
    
  var simplifiedPlayLists:[SimplifiedPlaylist] = []
    

    var player: SPTAudioStreamingController?
    var loginUrl: URL?
    

    @IBOutlet weak var loginButton: UIButton!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.updateAfterFirstLogin), name: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup () {
        // insert redirect your url and client ID below
        let redirectURL = "mymusicdemo://returnAfterLogin"
        auth.redirectURL     = URL(string: redirectURL)
        auth.clientID        = "277edce5ad1741fa8f29c73eec3a132c"
        auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = auth.spotifyWebAuthenticationURL()
        
    }
    
    
    func updateAfterFirstLogin () {
        
        loginButton.isHidden = true
        let userDefaults = UserDefaults.standard
        
        if let sessionObj:AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            
            self.session = firstTimeSession
           
            Spartan.authorizationToken = self.session.accessToken
            
            initializaPlayer(authSession: session)
            
            self.loginButton.isHidden = true
            
            //Display Playlist Screen
            let playlistStoryBoard = UIStoryboard(name: "PlayList", bundle: nil)
            let playlistNVC = playlistStoryBoard.instantiateViewController(withIdentifier: "PlaylistNVC") as! UINavigationController
            
            let playlistVC = playlistNVC.viewControllers[0] as! PlaylistViewController
            playlistVC.player = player  //pass player reference
            
            show(playlistNVC, sender: self)
        }
        
    }
    
    func initializaPlayer(authSession:SPTSession){
        
        if player == nil {
            
            
            player = SPTAudioStreamingController.sharedInstance()
            player!.playbackDelegate = self
            player!.delegate = self
            try! player?.start(withClientId: auth.clientID)
            player!.login(withAccessToken: authSession.accessToken)
        }
        
    }
    
//    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
//        // after a user authenticates a session, the SPTAudioStreamingController is then initialized and this method called
//        print("logged in")
//        self.player?.playSpotifyURI("spotify:track:58s6EuEYJdlb0kO7awm3Vp", startingWith: 0, startingWithPosition: 0, callback: { (error) in
//            if (error != nil) {
//                print("playing!")
//            }
//            
//        })
//        
//    }


    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if UIApplication.shared.openURL(loginUrl!) {
            
            if auth.canHandle(auth.redirectURL) {
                // To do - build in error handling
            }
        }
    }
    

    
    
    
}
