//
//  PlaylistViewController.swift
//  MyMusic
//
//  Created by Arthur Burgin on 4/30/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit
import Spartan
import AFNetworking
import BubbleTransition

class PlaylistViewController: UIViewController {
    
    @IBOutlet weak var bubbleSwtich: UIButton!
    var playlist: [Track] = []
    var player: SPTAudioStreamingController?
    let transition = BubbleTransition()
    
    
    override func viewDidLoad() {


    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapActivityPlaylist(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "PlayList", bundle: nil)
        let musicPlayerVC = storyBoard.instantiateViewController(withIdentifier: "MusicPlayer") as! MusicPlayerViewController
        
        present(musicPlayerVC, animated: true) {
            
        }
    }
    
    
    @IBAction func logout(_ sender: Any) {
        SpotifyService.deactivateAccount()
        FitbitAPI.deactivateAccount()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogout"), object: nil)
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let musicPlayerVC = segue.destination as! MusicPlayerViewController
     
        musicPlayerVC.playlistTracks = playlist
    }
    
    
}

extension PlaylistViewController: UIViewControllerTransitioningDelegate{
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = bubbleSwtich.center
        //transition.bubbleColor = bubbleSwtich.backgroundColor!
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = bubbleSwtich.center
        //transition.bubbleColor = bubbleSwtich.backgroundColor!
        return transition
    }
    
    @IBAction func switch2Activity(_ sender: Any) {
        let activityStoryBoard = UIStoryboard(name: "Activity", bundle: nil)
        let activityNVC = activityStoryBoard.instantiateViewController(withIdentifier: "ActivityNVC") as! UINavigationController
        
        activityNVC.transitioningDelegate = self
        activityNVC.modalPresentationStyle = .custom
        self.show(activityNVC, sender: nil)
        
    }
}
