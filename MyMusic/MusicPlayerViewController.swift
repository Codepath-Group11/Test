//
//  ViewController.swift
//  InteractivePlayerView
//
//  Created by AhmetKeskin on 02/09/15.
//  Copyright (c) 2015 Mobiwise. All rights reserved.
//

import UIKit
import Spartan
import Alamofire

class MusicPlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ipv: InteractivePlayerView!
    @IBOutlet weak var blurBgImage: UIImageView!
    @IBOutlet var songTitleLabel: UILabel!
    @IBOutlet var artistAndAlbumNameLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playPauseButtonView: UIView!
    
    var userID: String?
    var playlistID: String?
    var playlistType: String?
    var isReplaying: Bool = false
    var activity:String?
    
    var playlistTracks:[Track]?
    var copyPlaylistTracks:[Track]?
    var shuffledPlaylistTracks:[Track]?
    
    var currentSongIndex: Int = 0
    var currentDuration: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.view.layoutIfNeeded()
        self.view.backgroundColor = UIColor.clear
        self.makeItRounded(view: self.playPauseButtonView, newSize: self.playPauseButtonView.frame.width)
        
        MusicClient.getactivityPlaylist(activity: activity!, success: { (tracks:[Track]) in
            self.playlistTracks = tracks
            self.tableView.reloadData()
            let track = self.playlistTracks?[0]
            self.loadSongFromURI(uri: track?.uri ?? "")
        }) { (error:Error) in
            print(error.localizedDescription)
        }
        
        self.ipv!.delegate = self

        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "playlistUpdated"), object: nil, queue: OperationQueue.main) { (Notification) in
            self.playlistTracks = MusicClient.masterList
            self.tableView.reloadData()
            let track = self.playlistTracks?[0]
            self.loadSongFromURI(uri: track?.uri ?? "")
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissPlaylist(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func loadSongFromURI(uri: String?){
        let track = playlistTracks?[currentSongIndex]
        let duration = (track?.duration)!/1000
        
        songTitleLabel.text = track?.name
        artistAndAlbumNameLabel.text = "\(track?.artist ?? "") - \(track?.album ?? "")"
        
        blurBgImage.setImageWith(track?.albumCoverArtURL ?? URL(string:"")!)
        ipv.albumCoverImageView?.setImageWith(track?.albumCoverArtURL ?? URL(string:"")!)
        
        MusicClient.player().playSpotifyURI(uri, startingWith: 0, startingWithPosition: 0, callback: nil)
        
        playButton.isHidden = true
        pauseButton.isHidden = false
        
        ipv.durationLabel?.textColor = .red
        
        ipv.restartWithProgress(duration: Double(duration))
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
        let track = playlistTracks?[currentSongIndex]
        
        if playlistTracks != nil,  (currentSongIndex+1) < (playlistTracks?.count)!{
            currentSongIndex += 1
            
            loadSongFromURI(uri: track?.uri)
            ipv.stop()
        }
    }
    
    @IBAction func previousTapped(sender: AnyObject) {
        let track = playlistTracks?[currentSongIndex]
        
        if playlistTracks != nil, (currentSongIndex-1) > -1{
            currentSongIndex -= 1
            
            loadSongFromURI(uri: track?.uri ?? "")
            ipv.stop()
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
        
        currentSongIndex = indexPath.row
        let track = playlistTracks?[currentSongIndex]
        
        loadSongFromURI(uri: track?.uri ?? "")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell") as! TrackCell
        
        let track = playlistTracks?[indexPath.row]
        
        cell.textLabel?.text = track?.name
        cell.detailTextLabel?.text = track?.artist
        
        return cell
    }
    
}

extension MusicPlayerViewController: InteractivePlayerViewDelegate{
    
    /* InteractivePlayerViewDelegate METHODS */
    func actionOneButtonTapped(sender: UIButton, isSelected: Bool) {
        if isSelected{
            copyPlaylistTracks = playlistTracks
            
            shuffledPlaylistTracks = copyPlaylistTracks
            shuffledPlaylistTracks?.shuffle()
            
            playlistTracks = shuffledPlaylistTracks
            tableView.reloadData()
        }else{
            shuffledPlaylistTracks = []
            playlistTracks = copyPlaylistTracks
            tableView.reloadData()
        }
        
    }
    
    func actionTwoButtonTapped(sender: UIButton, isSelected: Bool) {
        print("like \(isSelected.description)")
    }
    
    func actionThreeButtonTapped(sender: UIButton, isSelected: Bool) {
        isReplaying = isSelected
        
    }
    
    func interactivePlayerViewDidChangedDuration(playerInteractive: InteractivePlayerView, currentDuration: Double) {
        self.currentDuration = currentDuration
        let track = playlistTracks?[currentSongIndex]
        
        let currentRoundedDuration = Int(currentDuration)
        let songTotalDuration = (track?.duration)!/1000
        
        if currentRoundedDuration == songTotalDuration, currentSongIndex != (playlistTracks?.count)!-1{
            if !isReplaying{
                currentSongIndex += 1
            }
            
            loadSongFromURI(uri: track?.uri ?? "")
        }
    }
    
    func interactivePlayerViewDidStartPlaying(playerInteractive: InteractivePlayerView) {
        playButton.isHidden = true
        pauseButton.isHidden = false
        MusicClient.player().setIsPlaying(true, callback: nil)
        MusicClient.player().playSpotifyURI(playlistTracks?[currentSongIndex].uri, startingWith: 0, startingWithPosition: currentDuration, callback: nil)
    }
    
    func interactivePlayerViewDidStopPlaying(playerInteractive: InteractivePlayerView) {
        playButton.isHidden = true
        pauseButton.isHidden = false
        MusicClient.player().setIsPlaying(false, callback: nil)
    }
    
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}
