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
    var playlists: [SimplifiedPlaylist] = []
    var player: SPTAudioStreamingController?
    
    @IBOutlet var noteImageView1: UIImageView!
    @IBOutlet var noteImageView2: UIImageView!
    @IBOutlet var noteImageView3: UIImageView!
    let transition = BubbleTransition()
    
    
    override func viewDidLoad() {
        
        // Do any additional setup after loading the view.
        MusicClient.getUserPlayLists(userId: "", musicServiceType: "", success: { (myPlaylists:[SimplifiedPlaylist]) in
            
            self.playlists = myPlaylists
            
        }) { (error:Error) in
            print(error.localizedDescription)
        }
        
        noteImageView1.alpha = 0
        noteImageView2.alpha = 0
        noteImageView3.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.noteImageView1.alpha = 1
            self.noteImageView1.transform.rotated(by: 20)
            
        }
        UIView.animate(withDuration: 1.5) {
            self.noteImageView2.alpha = 1
        }
        UIView.animate(withDuration: 2) {
            self.noteImageView3.alpha = 1
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapSettings(_ sender: UIBarButtonItem) {
        let nib = UIStoryboard.init(name: "Settings", bundle: nil)
        let settingsNav = nib.instantiateViewController(withIdentifier: "SettingNavigationViewController")
        self.show(settingsNav, sender: true)
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

    /*// In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }*/
    
    
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
