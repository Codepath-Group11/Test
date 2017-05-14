//
//  CategoryView.swift
//  MyMusic
//
//  Created by kathy yin on 5/14/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

class CategoryView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImg: UIImageView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    
    func initSubView() {
        let xib = UINib(nibName: "CategoryView", bundle: nil)
        xib.instantiate(withOwner: self, options: nil)
        contentView.frame = self.bounds
        self.backgroundColor = UIColor.clear
        self.addSubview(contentView)
        self.categoryLabel.layer.cornerRadius = 5
    }
}
