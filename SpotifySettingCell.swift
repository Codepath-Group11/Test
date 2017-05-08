//
//  SpotifySettingCell.swift
//  MyMusic
//
//  Created by kathy yin on 5/8/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

protocol SpotifySettingCellDelegate :class{
    func didChangeSpotifLoginStatus(isOn: Bool)
}

class SpotifySettingCell: UITableViewCell {
    
    @IBOutlet weak var loginSwitch: UISwitch!
    weak var delegate: SpotifySettingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onSwitchLoginStatus(_ sender: UISwitch) {
        delegate?.didChangeSpotifLoginStatus(isOn: sender.isOn)
    }
}
