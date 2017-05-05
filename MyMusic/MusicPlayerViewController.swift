//
//  ViewController.swift
//  InteractivePlayerView
//
//  Created by AhmetKeskin on 02/09/15.
//  Copyright (c) 2015 Mobiwise. All rights reserved.
//

import UIKit
import Spartan

class MusicPlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ipv: InteractivePlayerView!
     @IBOutlet weak var blurBgImage: UIImageView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playPauseButtonView: UIView!
    
    var userID: String?
    var playlistID: String?
    
    var playlistTracks:[PlaylistTrack]?
    var currentSongIndex: Int = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.layoutIfNeeded()
        self.view.backgroundColor = UIColor.clear
        self.makeItRounded(view: self.playPauseButtonView, newSize: self.playPauseButtonView.frame.width)

        self.ipv!.delegate = self
        
        // duration of music
        self.ipv.progress = 20.0
        
        _ = Spartan.getPlaylistTracks(userId: userID ?? "", playlistId: playlistID ?? "", success: { (PagingObject) in
            self.playlistTracks = PagingObject.items
            self.tableView.reloadData()
        }, failure: { (error:SpartanError) in
            print(error.errorMessage)
        })
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissPlaylistModal(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func loadSongFromURI(uri: String){
        MusicClient.player().playSpotifyURI(uri, startingWith: 0, startingWithPosition: 0, callback: nil)
        playButton.isHidden = true
        pauseButton.isHidden = false
    }
    
    func changePlayPause(){
        if playButton.isHidden{
            playButton.isHidden = false
            pauseButton.isHidden = true
        }else{
            playButton.isHidden = true
            pauseButton.isHidden = false
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
            ipv.start()
            MusicClient.player().setIsPlaying(true, callback: nil)
            changePlayPause()
        
    }

    @IBAction func pauseButtonTapped(_ sender: UIButton) {
            ipv.stop()
            MusicClient.player().setIsPlaying(false, callback: nil)
            changePlayPause()
        
    }
    
    
    @IBAction func nextTapped(sender: AnyObject) {
        var trackURI = ""
        if playlistTracks != nil,  (currentSongIndex+1) < (playlistTracks?.count)!{
            currentSongIndex += 1
            
            let duration = (playlistTracks?[currentSongIndex].track.durationMs)!/1000
            
            trackURI = (playlistTracks?[currentSongIndex].track.uri)!
            
            loadSongFromURI(uri: trackURI)
            ipv.stop()
            ipv.restartWithProgress(duration: Double(duration))
        }
    }
    
    @IBAction func previousTapped(sender: AnyObject) {
        var trackURI = ""
        if playlistTracks != nil, (currentSongIndex-1) > -1{
            currentSongIndex -= 1
            
            let duration = (playlistTracks?[currentSongIndex].track.durationMs)!/1000
            
            trackURI = (playlistTracks?[currentSongIndex].track.uri)!
            
            loadSongFromURI(uri: trackURI)
            ipv.stop()
            ipv.restartWithProgress(duration: Double(duration))
        }
    }
    
    func makeItRounded(view : UIView!, newSize : CGFloat!){
        let saveCenter : CGPoint = view.center
        let newFrame : CGRect = CGRect(x: view.frame.origin.x,y: view.frame.origin.y,width: newSize,height : newSize)
        view.frame = newFrame
        view.layer.cornerRadius = newSize / 2.0
        view.clipsToBounds = true
        view.center = saveCenter
        
    }
    
    //MARK: tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if playlistTracks?.count != nil{
            return (playlistTracks?.count)!
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let trackURI = playlistTracks?[indexPath.row].track.uri
        currentSongIndex = indexPath.row
        
        let duration = (playlistTracks?[currentSongIndex].track.durationMs)!/1000
        
        if trackURI != nil{
            loadSongFromURI(uri: trackURI!)
            ipv.restartWithProgress(duration: Double(duration))
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell") as! TrackCell
        
        let track = playlistTracks?[indexPath.row].track
        
        cell.textLabel?.text = track?.name
        cell.detailTextLabel?.text = track?.artists[0].name
        
        return cell
    }
    
}

extension MusicPlayerViewController: InteractivePlayerViewDelegate{
    
    /* InteractivePlayerViewDelegate METHODS */
    func actionOneButtonTapped(sender: UIButton, isSelected: Bool) {
        print("shuffle \(isSelected.description)")
    }
    
    func actionTwoButtonTapped(sender: UIButton, isSelected: Bool) {
        print("like \(isSelected.description)")
    }
    
    func actionThreeButtonTapped(sender: UIButton, isSelected: Bool) {
        print("replay \(isSelected.description)")
        
    }
    
    func interactivePlayerViewDidChangedDuration(playerInteractive: InteractivePlayerView, currentDuration: Double) {
        print("current Duration : \(currentDuration)")
    }
    
    func interactivePlayerViewDidStartPlaying(playerInteractive: InteractivePlayerView) {
        print("interactive player did started")
    }
    
    func interactivePlayerViewDidStopPlaying(playerInteractive: InteractivePlayerView) {
        print("interactive player did stop")
    }
    
}
