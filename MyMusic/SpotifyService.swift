//
//  SpotifyService.swift
//  MyMusic
//
//  Created by Yerneni, Naresh on 4/29/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import Foundation
import Spartan

class SpotifyService {
    
    var simplifiedPlayLists:[SimplifiedPlaylist] = []

    //var musicClient = MusicClient()
    
 func getUserPlayLists(userId:String,success:@escaping([SimplifiedPlaylist]) -> (),failure:@escaping (Error) ->()) {
    
    // Add user id here to pull the play lists.
    _ = Spartan.getUsersPlaylists(userId: "", limit: 20, offset: 0, success: { (pagingObject) in
        
        // Get the playlists via pagingObject.playlists
        self.simplifiedPlayLists = pagingObject.items as [SimplifiedPlaylist]
        success(self.simplifiedPlayLists)
        
    }, failure: { (error) in
        print(error)
    })
    // musicClient.getUserPlayLists(userId:userId,musicServiceType:"",success:success,failure:failure)
    }

    
  
    
}
