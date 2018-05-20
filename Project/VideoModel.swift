//
//  VideoModel.swift
//  Project
//
//  Created by Meher Jyoti Singh on 5/4/18.
//  Copyright © 2018 Meher Jyoti Singh. All rights reserved.
//

import UIKit
import Alamofire

protocol VideoModelDelegate {
    func dataReady()
}

class VideoModel: NSObject {
    //ApI key: "AIzaSyCqyUQnsG9u-qyw_-G-KqFdPTI_GRQ-cx0"
    let API_KEY = "AIzaSyAKYxf9GFeU3aBpD_RHa__1KNZDui0fZO8"
    let CHANNEL_ID = "UC6-UA1FoMnbO2LCLWPCM9aA"
    let Playlist_ID = "PLiRG83hKoub8soaZdrLI2CEqU4P5-W39s"
    
    var videoArray = [Video]()
    
    var delegate:VideoModelDelegate?
    
    func getFeedVideos(){
        
        Alamofire.request("https://www.googleapis.com/youtube/v3/search", method: HTTPMethod.get, parameters: ["part":"snippet", "playlistId": Playlist_ID, "key": API_KEY,"channelId": CHANNEL_ID, "maxResults": 20], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            if let JSON = response.result.value {
                if let dict = JSON as? [String: Any]{
                    
                    var arrayOfVideos = [Video]()
                    for video in dict["items"] as! [AnyObject] {
                        
                        let videoObj = Video()
                        videoObj.videoId = video.value(forKeyPath: "snippet.resourceId.videoId") as! String
                        videoObj.videoTitle = video.value(forKeyPath: "snippet.title") as! String
                        videoObj.videoDescription = video.value(forKeyPath: "snippet.description") as! String
                        videoObj.videoThumbnailUrl = video.value(forKeyPath: "snippet.thumbnails.high.url") as! String

                        arrayOfVideos.append(videoObj)
                        
                    }
                    self.videoArray = arrayOfVideos

                    if self.delegate != nil{
                        self.delegate!.dataReady()
                    }
                }
            }
        }
    }
        
}

