//
//  SpinView.swift
//  MyMusic
//
//  Created by kathy yin on 5/7/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

class SpinView: UIView {
    var spinImage: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let image = UIImage(named: "mymusic")
        spinImage = UIImageView(image: image)
        spinImage.frame = self.bounds
        self.addSubview(spinImage)
        
        let transition = CATransition()
        transition.startProgress = 0;
        transition.endProgress = 1.0;
        transition.type = "flip";
        transition.subtype = "fromRight";
        transition.duration = 0.3;
        transition.repeatCount = 5;
        self.layer.add(transition, forKey: "spin")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
