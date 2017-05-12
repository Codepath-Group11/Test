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
    
    class func getTracksFromId(){
        var stringIds = ""
        var IDStringWithoutLastComma = ""
        for id in customFinalTrackIds{
            stringIds += "\(id) "
        }
        let idsForEndpoint = stringIds.replacingOccurrences(of: " ", with: ",")
        if idsForEndpoint != ""{
            IDStringWithoutLastComma = idsForEndpoint.substring(to: idsForEndpoint.index(before: idsForEndpoint.endIndex))
        }
        
        let endpoint: String = "https://api.spotify.com/v1/tracks/?ids=\(IDStringWithoutLastComma)"
        
        guard let url = URL(string: endpoint) else {
            print("Can't make request")
            return
        }
        var urlRequest = URLRequest(url:url)
        urlRequest.addValue("Authorization: Bearer", forHTTPHeaderField: authorization().session.accessToken)
        
        //setup session
        let session = URLSession.shared
    
        //make the request
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
            masterList = []
            masterList = Track.tracksFromJSON(json!!)
            masterList.dropFirst()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "playlistUpdated"), object: nil)
        }
        task.resume()
    }
    
    class func getFeatures(trackIds:[String], trackInfo:[String:String], _ choiceTempo: Double, _ choiceMood: Double, _ choiceDance: Double, _ choiceEnergy: Double){
        _ = Spartan.getAudioFeatures(trackIds: trackIds, success: { (Objs:[AudioFeaturesObject]) in
            for Obj in Objs{
                
                let songTempo:Double = Obj.tempo!
                let songMood:Double = Obj.valence!
                let songDance:Double = Obj.danceability!
                let songEnergy:Double = Obj.energy!
                
                if (140.0000 ..< 180).contains(songTempo) || (0.040 ..< 0.080).contains(songMood) || (0.040 ..< 0.080).contains(songDance) && (0.040 ..< 0.080).contains(songEnergy){
                    for (_ , value) in trackInfo{
                        if Obj.id == value{
                            if customFinalTrackIds.count <= 49{
                                customFinalTrackIds.append(value)
                            }
                        }
                    }
                }
                
            }
        }, failure: { (error:SpartanError) in
            print(error.errorMessage)
        })
    }
    
    class func getCustomizedPlaylist(tempo: Double, mood: Double, dance: Double, energy: Double){
        var trackInfo = [String:String]()
        var trackIds:[String] = []
        var count = 0
        for (i, track) in masterList.enumerated(){
            trackInfo[track.name!] = track.id
            if count < 100{
                trackIds.append(track.id!)
                count += 1
                if i == masterList.count-1{
                    MusicClient.getFeatures(trackIds: trackIds, trackInfo: trackInfo, tempo, mood, dance, energy)
                }
            }else{
                MusicClient.getFeatures(trackIds: trackIds, trackInfo: trackInfo, tempo, mood, dance, energy)
                count = 0
                trackIds = []
            }

        }
        
    }
    
    private class func getMixedWorkoutPlaylistTracks(workoutPlaylists: [SimplifiedPlaylist], success: @escaping ([Track])->()){
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
    
    class func getWorkoutPlayList(success:@escaping([Track]) -> (),failure:@escaping (Error) ->()) {
        
        var randomPlaylists:[SimplifiedPlaylist] = []
        
        _ = Spartan.getCategorysPlaylists(categoryId: "workout", success: { (PagingObject) in
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
            
            MusicClient.getMixedWorkoutPlaylistTracks(workoutPlaylists: randomPlaylists, success: { (tracks:[Track]) in
                success(tracks)
                
            })

        }, failure: { (error:SpartanError) in
            print(error.errorMessage)
        })
        
    }

    
}



