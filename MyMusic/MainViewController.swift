//
//  MainViewController.swift
//  MyMusic
//
//  Created by kathy yin on 5/7/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import Parse
class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if MusicClient.checkCurrentSession() {
            showPlaylistInterface()
        } else {
            //presentSettingInterface()
            //presentLoginInterface()
            presentWelcomInterface()
        }
    }
    
    /*
    func checkUser() {
        let spotify = MusicClient.checkCurrentSession()
        MusicClient.getSpotfiy(credential: { (token, user) in
            if let user = user {
                let spotifyId: String = user.canonicalUserName
                self.queryPaeseUserWith(spotifyId: spotifyId)
            }
        })
    }

    func queryPaeseUserWith(spotifyId: String) {
        let query = PFUser.query()
        query?.whereKey("spotifyId", equalTo: spotifyId)
        query?.getFirstObjectInBackground(block: { (result, error) in
                if let result = result {
                    print("user exist")

                } else {
                    print("user not exist")
                }
        })
    }
   */
    func presentWelcomInterface() {
        let nib = UIStoryboard(name: "Login", bundle: nil)
        let intro = nib.instantiateViewController(withIdentifier: "IntroViewController")
        self.present(intro, animated: false, completion: nil)
    }
    
    func presentLoginInterface() {
        let loginNib = UIStoryboard(name: "Login", bundle: nil)
        let loginNVC = loginNib.instantiateViewController(withIdentifier: "loginNavigationViewController") as! UINavigationController
        self.present(loginNVC, animated: true, completion: nil)
    }
    
    func showPlaylistInterface() {
        let playlistStoryBoard = UIStoryboard(name: "PlayList", bundle: nil)
        let playlistNVC = playlistStoryBoard.instantiateViewController(withIdentifier: "ActivityPlaylistNVC") as! UINavigationController
        
        self.show(playlistNVC, sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func checkCurrentParseUser() -> (Bool) {
        let user = PFUser.current()
        if user != nil {
            user?.fetchIfNeededInBackground { (result, error) -> Void in
                /* user fetch resutlt */
                let spotifyId  = user?.object(forKey: "spotifyId")
                let spotifyAccessToken = user?.object(forKey: "spotifyToken")
            }
            return true
        } else {
            return false
        }
    }
    */
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
