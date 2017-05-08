//
//  FitBitSettingCell.swift
//  MyMusic
//
//  Created by kathy yin on 5/8/17.
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

protocol FitbitSettingCellDelegate : class {
    func didChangefitbitAccountLoginStatus(isOn: Bool)
}

class FitbitSettingCell: UITableViewCell {
    @IBOutlet weak var loginSwitch: UISwitch!
    weak var delegate: FitbitSettingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onChangeFitbitLoginStatus(_ sender: UISwitch) {
        delegate?.didChangefitbitAccountLoginStatus(isOn: sender.isOn)
    }

}
