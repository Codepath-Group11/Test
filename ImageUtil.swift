//
//  ImageUtil.swift
//  MyMusic
//
//  Created by kathy yin on 5/17/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit

class ImageUtil {
   class func getImageFromVideo(videoURL: String) -> UIImage {
        do {
            let asset = AVURLAsset(url: URL(fileURLWithPath: videoURL), options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            let image = UIImage(cgImage: cgImage)
            return image
        } catch {
            print("error")
            return UIImage()
        }
    }
}
