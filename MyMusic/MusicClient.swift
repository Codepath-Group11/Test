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
import Alamofire

class MusicClient: NSObject{
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    private static var service = SpotifyService()
    static var masterList:[Track] = []
    static var customMasterList:[Track] = []
    static var customFinalTrackIds:[String] = []
    
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
    
    class func getactivityPlaylist(activity: String, success:@escaping([Track]) -> (),failure:@escaping (Error) ->()){
        masterList = []
        switch activity {
        case "Weights":
            let beastModeID = "37i9dQZF1DX76Wlfdnj7AP"
            _ = Spartan.getPlaylistTracks(userId: "spotify", playlistId: beastModeID, success: { (PagingObject) in
                
                masterList += Track.tracksInArray(array: PagingObject.items)
                let pumpingIronID = "37i9dQZF1DWZYWNM3NfvzJ"
                
                _ = Spartan.getPlaylistTracks(userId: "spotify", playlistId: pumpingIronID, success: { (PagingObject) in
                    masterList += Track.tracksInArray(array: PagingObject.items)
                    success(masterList)
                }, failure: { (error:SpartanError) in
                    print(error.errorMessage)
                })
            }, failure: { (error:SpartanError) in
                print(error.errorMessage)
            })
        case "Treadmill":
            let motivationMixID = "37i9dQZF1DXdxcBWuJkbcy"
            _ = Spartan.getPlaylistTracks(userId: "spotify", playlistId: motivationMixID, success: { (PagingObject) in
                
                masterList += Track.tracksInArray(array: PagingObject.items)
                let powerWalkID = "37i9dQZF1DX9BXb6GsGCLl"
                
                _ = Spartan.getPlaylistTracks(userId: "spotify", playlistId: powerWalkID, success: { (PagingObject) in
                    masterList += Track.tracksInArray(array: PagingObject.items)
                    success(masterList)
                }, failure: { (error:SpartanError) in
                    print(error.errorMessage)
                })
            }, failure: { (error:SpartanError) in
                print(error.errorMessage)
            })
        case "Run":
            let cardioID = "37i9dQZF1DWSJHnPb1f0X3"
            _ = Spartan.getPlaylistTracks(userId: "spotify", playlistId: cardioID, success: { (PagingObject) in
                
                masterList += Track.tracksInArray(array: PagingObject.items)
                let powerWorkoutID = "37i9dQZF1DWUVpAXiEPK8P"
                
                _ = Spartan.getPlaylistTracks(userId: "spotify", playlistId: powerWorkoutID, success: { (PagingObject) in
                    masterList += Track.tracksInArray(array: PagingObject.items)
                    success(masterList)
                }, failure: { (error:SpartanError) in
                    print(error.errorMessage)
                })
            }, failure: { (error:SpartanError) in
                print(error.errorMessage)
            })
        case "Elliptical":
            let latinDanceCardioID = "37i9dQZF1DX7cmFV9rWM0u"
            _ = Spartan.getPlaylistTracks(userId: "spotify", playlistId: latinDanceCardioID, success: { (PagingObject) in
                
                masterList += Track.tracksInArray(array: PagingObject.items)
                let danceWorkoutID = "37i9dQZF1DX35oM5SPECmN"
                
                _ = Spartan.getPlaylistTracks(userId: "spotify", playlistId: danceWorkoutID, success: { (PagingObject) in
                    masterList += Track.tracksInArray(array: PagingObject.items)
                    success(masterList)
                }, failure: { (error:SpartanError) in
                    print(error.errorMessage)
                })
            }, failure: { (error:SpartanError) in
                print(error.errorMessage)
            })
        default:
            getPlaylistsFromWorkoutCategory(success: { (tracks:[Track]) in
                masterList += tracks
                success(masterList)
            }, failure: { (error:Error) in
                print(error.localizedDescription)
            })
        }
    }
    
    private class func getCustomWorkoutPlaylistTracks(workoutPlaylists: [SimplifiedPlaylist], success: @escaping ([Track])->()){
        var savedTracks = [Track]()
        masterList = []
        for (playlistIndex, playlist) in workoutPlaylists.enumerated(){
            _ = Spartan.getPlaylistTracks(userId: "spotify", playlistId: playlist.id, success: { (PagingObject) in
                masterList += Track.tracksInArray(array: PagingObject.items)
                var playlistTracks = Track.tracksInArray(array: PagingObject.items)
                
                for trackIndex in 0...5{
                    if playlistIndex == workoutPlaylists.count-1, trackIndex == 9{
                        success(savedTracks)
                    }
                    //masterList.append(playlistTracks[trackIndex])
                    savedTracks.append(playlistTracks[trackIndex])
                }
            }, failure: { (error:SpartanError) in
                if savedTracks.count >= 20{
                    success(savedTracks)
                }
            })
        }
    }
    
    class func getPlaylistsFromWorkoutCategory(success:@escaping([Track]) -> (),failure:@escaping (Error) ->()) {
        
        var randomPlaylists:[SimplifiedPlaylist] = []
        
        _ = Spartan.getCategorysPlaylists(categoryId: "workout", success: { (PagingObject) in
            for item in PagingObject.items{
                print(item.name)
                print(item.id)
            }
            
            for _ in 0 ..< 15{
                
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
            
            MusicClient.getCustomWorkoutPlaylistTracks(workoutPlaylists: randomPlaylists, success: { (tracks:[Track]) in
                success(tracks)
                
            })
            
        }, failure: { (error:SpartanError) in
            print(error.errorMessage)
        })
        
    }
    
    
}



