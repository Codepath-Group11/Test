//
//  fitBitOauthViewController.swift
//  MyMusic
//
//  Created by kathy yin on 5/8/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class FitBitOauthController: UIViewController , AuthenticationProtocol {

    var player: AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        let videoURL: URL = Bundle.main.url(forResource: "intro4", withExtension: "mp4")!
        
        player = AVPlayer(url: videoURL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        playerLayer.frame = view.frame
        view.layer.addSublayer(playerLayer)
        player?.play()
        //loop video
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(FitBitOauthController.loopVideo),
                                               name: Notification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: nil)
        authenticationController = FitbitAuthenticationController(delegate: self)
        // Do any additional setup after loading the view.
    }
    
    var authenticationController: FitbitAuthenticationController?
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //User tap fitbitauth button
    @IBAction func connectWithFitbit(_ sender: UIButton) {
        //Fitbit oauth
         authenticationController?.login(fromParentViewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(didConnectWithFitbit), name: NSNotification.Name(rawValue: "FitbitLoginSuccessful"), object: nil)
     
        
    }

    func didConnectWithFitbit() {
        let playlistStoryBoard = UIStoryboard(name: "PlayList", bundle: nil)
        let playlistNVC = playlistStoryBoard.instantiateViewController(withIdentifier: "ActivityPlaylistNVC") as! UINavigationController
        self.show(playlistNVC, sender: nil)
    }

    func authorizationDidFinish(_ success: Bool) {
        
//        guard let authToken = authenticationController?.authenticationToken else {
//            return
//        }
//        FitbitAPI.sharedInstance.authorize(with: authToken)
//        // Get Fav Activities
//        let _ = FitbitAPI.fetchFavActivities() { favActivities,error in
//            print(favActivities)
//        }
//        //Get Daily Activity
//        let day = "/2017-05-07.json"
//        let _ = FitbitAPI.fetchDailyActivitySummary(for:day){[weak self] dailyActSummary,error in
//            print(dailyActSummary)
        
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FitbitLoginSuccessful"), object: nil)
        }
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
}
