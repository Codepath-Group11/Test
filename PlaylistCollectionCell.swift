//
//  PlaylistCollectionCell.swift
//  MyMusic
//
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

class PlaylistCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var activityCollectionView: ActivityCollectionView!
    var imageName: String? {
        didSet {
            if let name = imageName {
                if let img = UIImage(named: name) {
                    activityCollectionView.activityImageView.image = img
                    activityCollectionView.activityImageView.alpha = 0.8
                }
            }
        }
    }

    var title: String! {
        didSet {
            activityCollectionView.activityLabel.text = title
        }
    }
}
