//
//  ActivityCell.swift
//  MyMusic
//
//  Created by Arthur Burgin on 5/13/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    @IBOutlet var progressView: UIView!
    @IBOutlet var activityResultsLabel: UILabel!
    @IBOutlet var activityTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func animateRedBar(){
        progressView.backgroundColor = UIColor(red: 255/255, green: 94/255, blue: 61/255, alpha: 1)
        progressView.frame.size.width = 0
        
        UIView.animate(withDuration: 2) {
            self.progressView.frame.size.width = 343
            
        }
    }
    
    func animateBlueBar(){
        progressView.backgroundColor = UIColor(red: 28/255, green: 166/255, blue: 223/255, alpha: 1)
        progressView.frame.size.width = 0
        
        UIView.animate(withDuration: 2) {
            self.progressView.frame.size.width = 192
        }
    }
    
    func animateGreenBar(){
        progressView.backgroundColor = UIColor(red: 72/255, green: 164/255, blue: 29/255, alpha: 1)
        progressView.frame.size.width = 0
        
        UIView.animate(withDuration: 2) {
            self.progressView.frame.size.width = 171
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
