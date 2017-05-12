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

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIViewControllerTransitioningDelegate {
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var bubbleSwtich: UIButton!
    var playlists: [SimplifiedPlaylist] = []
    var player: SPTAudioStreamingController?
    var activities:[String] = ["Run", "Elliptical", "Weights", "Treadmill"]
    
    let transition = BubbleTransition()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        MusicClient.getUserPlayLists(userId: "", musicServiceType: "", success: { (myPlaylists:[SimplifiedPlaylist]) in
            
            self.playlists = myPlaylists
            
            self.tableView.reloadData()
        }) { (error:Error) in
            print(error.localizedDescription)
        }
        
//        _ = Spartan.getCategorysPlaylists(categoryId: "workout", success: { (PagingObject) in
//            let playlists = PagingObject.items
//            for (_, value) in (playlists?.enumerated())!{
//                print("\(value.name)")
//            }
//        }, failure: { (error:SpartanError) in
//            
//        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return activities.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell") as! PlaylistCell
        
        let activity = activities[indexPath.row]
        
        cell.titleLabel.text = activity
        cell.trackCountLabel.text = ""
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! PlaylistCell
        let indexPath = tableView.indexPath(for: cell)!
        let activity = activities[indexPath.row]
        
        let mvc = segue.destination as! MusicPlayerViewController
        //mvc.spotifyPlayer = player  //send player reference to musicPlayer
//
//        mvc.playlistID = playlists[indexPath.row].id
//        mvc.userID = playlists[indexPath.row].owner.id
        switch activity {
        case "Run":
            mvc.playlistType = "Motivation Mix"
        case "Treadmill":
            mvc.playlistType = "Cardio"
        case "Elliptical":
            mvc.playlistType = "Spin Fit"
        case "Weights":
            mvc.playlistType = "Power Workout"
        default:
            mvc.playlistType = "Heroic Workout"
        }
    }

    @IBAction func onTapSettings(_ sender: UIBarButtonItem) {
        let nib = UIStoryboard.init(name: "Settings", bundle: nil)
        let settingsNav = nib.instantiateViewController(withIdentifier: "SettingNavigationViewController")
        self.show(settingsNav, sender: true)
    }
    
    
    @IBAction func logout(_ sender: Any) {
        SpotifyService.deactivateAccount()
        FitbitAPI.deactivateAccount()
        
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogout"), object: nil)
        
       }
    

    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = bubbleSwtich.center
        transition.bubbleColor = bubbleSwtich.backgroundColor!
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = bubbleSwtich.center
        transition.bubbleColor = bubbleSwtich.backgroundColor!
        return transition
    }
    
    @IBAction func switch2Activity(_ sender: Any) {
        let playlistStoryBoard = UIStoryboard(name: "Activity", bundle: nil)
        let activityNVC = playlistStoryBoard.instantiateViewController(withIdentifier: "ActivityNVC") as! UINavigationController
        
        activityNVC.transitioningDelegate = self
        activityNVC.modalPresentationStyle = .custom
       self.show(activityNVC, sender: nil)
        
    }
    
    
}
