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
    
    init(_ dictionairy: NSDictionary){
        print(dictionairy["name"])
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
