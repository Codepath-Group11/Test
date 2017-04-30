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

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    var playlists: [SimplifiedPlaylist] = []
    var player: SPTAudioStreamingController?
    
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if playlists.count > 0{
            return playlists.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell") as! PlaylistCell
        
        let playlist = playlists[indexPath.row]
        
        cell.titleLabel.text = playlist.name
        cell.trackCountLabel.text = "\(playlist.tracksObject.total ?? 0)"
        
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
        
        let mvc = segue.destination as! MusicPlayerViewController
        mvc.spotifyPlayer = player  //send player reference to musicPlayer
        
        mvc.playlistID = playlists[indexPath.row].id
        mvc.userID = playlists[indexPath.row].owner.id
    }

}
