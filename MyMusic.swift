//
//  MyMusic.swift
//  MyMusic
//
//  Created by kathy yin on 5/8/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

@IBDesignable
class MyMusic: UIView {
 
    
    @IBOutlet var contentView: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }

    func initSubView() {
        let xib = UINib(nibName: "MyMusic", bundle: nil)
        xib.instantiate(withOwner: self, options: nil)
        contentView.frame = self.bounds
        self.addSubview(contentView)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
