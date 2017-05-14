//
//  MainViewController.swift
//  MyMusic
//
//  Created by kathy yin on 5/7/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import Parse
import BubbleTransition
class MainViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    
    @IBOutlet weak var bubblePositionButton: UIButton!
    let transition = BubbleTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bubblePositionButton.layer.cornerRadius = bubblePositionButton.frame.width/2
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //if MusicClient.checkCurrentSession() {
        //    showPlaylistInterface()
        //} else {
            //presentSettingInterface()
            //presentLoginInterface()
        //    presentWelcomInterface()
        //}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showActivity" {
            let toViewController = segue.destination
            toViewController.transitioningDelegate = self
            toViewController.modalPresentationStyle = .custom
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.duration = 0.3
        transition.transitionMode = .present
        transition.startingPoint = bubblePositionButton.center
        transition.bubbleColor =  bubblePositionButton.backgroundColor!
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.duration = 0.3
        transition.transitionMode = .dismiss
        transition.startingPoint = bubblePositionButton.center
        transition.bubbleColor =  bubblePositionButton.backgroundColor!
        return transition
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
        self.present(intro, animated: true, completion: nil)
    }
    
    func presentLoginInterface() {
        let loginNib = UIStoryboard(name: "Login", bundle: nil)
        let loginNVC = loginNib.instantiateViewController(withIdentifier: "loginNavigationViewController") as! UINavigationController
        self.present(loginNVC, animated: true, completion: nil)
    }
    
    func showPlaylistInterface() {
        let playlistStoryBoard = UIStoryboard(name: "PlayList", bundle: nil)
        let playlistNVC = playlistStoryBoard.instantiateViewController(withIdentifier: "PlaylistNVC") as! UINavigationController
        
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
