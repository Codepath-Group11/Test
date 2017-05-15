//
//  Track.swift
//  MyMusic
//
//  Created by Arthur Burgin on 5/9/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import Foundation
import Spartan

class Track: NSObject{
    var name: String?
    var album: String?
    var artist: String?
    var duration: Int?
    var id: String?
    var uri: String?
    var albumCoverArtURL: URL?
    
    init(_ PagingObject: PlaylistTrack) {
        let track = PagingObject.track
        
        name = track?.name
        album = track?.album.name
        artist = track?.artists[0].name
        duration = track?.durationMs
        id = track?.id
        uri = track?.uri
        albumCoverArtURL = URL(string: track?.album.images[0].url ?? "")
    }
    
    init(_ dictionary: NSDictionary){
        name = dictionary["name"] as? String
        duration = dictionary["duration_ms"] as? Int
        id = dictionary["id"] as? String
        uri = dictionary["uri"] as? String
        
        let albumDict = dictionary["album"] as? NSDictionary
        album = albumDict?["name"] as? String
        
        let artistsArr = albumDict?["artists"] as? NSArray
        let artistObj = artistsArr?[0] as? NSDictionary
        artist = artistObj?["name"] as? String
        
        let albumImagesArr = albumDict?["images"] as? NSArray
        let albumImageObj = albumImagesArr?[0] as? NSDictionary
        let albumURLString = albumImageObj?["url"] as? String
        albumCoverArtURL = URL(string: albumURLString ?? "")
    }
    
    class func tracksFromJSON(_ dictionary: NSDictionary)->[Track]{
        var tracks = [Track]()
        
        let dictTracks = dictionary["tracks"] as? NSArray
        
        for track in dictTracks!{
            let track = Track(track as! NSDictionary)
            tracks.append(track)
        }
        return tracks
    }
    
    class func tracksInArray(array:[PlaylistTrack])->[Track]{
        var tracks = [Track]()
        
        for track in array{
            let track = Track(track)
            tracks.append(track)
        }
        return tracks
    }
}
