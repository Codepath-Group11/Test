//
//  Client.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 4/27/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

import BDBOAuth1Manager
import Spartan

class MusicClient: NSObject{
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    private static var service = SpotifyService()
    
    class func player() -> SPTAudioStreamingController{
        return service.player!
    }
    
    class func getLoginURL()->URL{
        return service.loginUrl!
    }
    
    class func authorization()-> SPTAuth {
        return service.auth
    }
    
    class func configuSpotifyService() {
        service.configSpotify()
    }
    
    class func handleSpotifyURL(url: URL) -> Bool {
        return service.handleURL(url: url)
    }
    
    class func checkCurrentSession() -> Bool {
        return service.checkUserSessionExist()
    }
    
    private class func getMixedWorkoutPlaylistTracks(workoutPlaylists: [SimplifiedPlaylist], success: @escaping ([Track])->()){
        var savedTracks = [Track]()
        
        for (playlistIndex, playlist) in workoutPlaylists.enumerated(){
            _ = Spartan.getPlaylistTracks(userId: "spotify", playlistId: playlist.id, success: { (PagingObject) in
                var playlistTracks = Track.tracksInArray(array: PagingObject.items)
                
                for (trackIndex, track) in playlistTracks.enumerated(){
                    if playlistIndex == workoutPlaylists.count-1, trackIndex == 9{
                        success(savedTracks)
                    }
                    
                    let randomNum: UInt32 = arc4random_uniform(20)
                    
                    savedTracks.append(playlistTracks[Int(randomNum)])
                    
                    let lengthOfSavedTracks = savedTracks.count
                    
                    for i in 0...lengthOfSavedTracks-1{
                        if savedTracks[i].name == track.name{
                            let randomNum: UInt32 = arc4random_uniform(20)
                            savedTracks[i] = playlistTracks[Int(randomNum)]
                        }
                    }
                }
            }, failure: { (error:SpartanError) in
                if savedTracks.count >= 5{
                    success(savedTracks)
                }
            })
        }
    }
    
    class func getWorkoutPlayList(success:@escaping([Track]) -> (),failure:@escaping (Error) ->()) {
        var randomPlaylists:[SimplifiedPlaylist] = []
        
        _ = Spartan.getCategorysPlaylists(categoryId: "workout", success: { (PagingObject) in
            for _ in 0...5{
                
                let randomNum: UInt32 = arc4random_uniform(20)
                randomPlaylists.append(PagingObject.items[Int(randomNum)])
                
                let lengthOfPlaylist = randomPlaylists.count
                
                for i in 0...lengthOfPlaylist-1{
                    if randomPlaylists[i].name == PagingObject.items[Int(randomNum)].name{
                        let randomNum: UInt32 = arc4random_uniform(20)
                        randomPlaylists[i] = PagingObject.items[Int(randomNum)]
                    }
                }
            }
            
            MusicClient.getMixedWorkoutPlaylistTracks(workoutPlaylists: randomPlaylists, success: { (tracks:[Track]) in
                success(tracks)
            })

        }, failure: { (error:SpartanError) in
            print(error.errorMessage)
        })
        
    }

    
}



