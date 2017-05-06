//
//  SingUpEntryCell.swift
//  MyMusic
//
//  Copyright © 2017 Yerneni, Naresh. All rights reserved.
//

import UIKit

protocol SignUpEntryCellDelegate : class {
    func userDidEnterData(in cell: SignUpEntryCell, field: UITextField, type: entryType, data: String)
}

class SignUpEntryCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var inputField: UITextField!
    weak var delegate: SignUpEntryCellDelegate?
    var entry: entryType = .email {
        didSet {
            inputField.placeholder = entry.rawValue
            switch entry {
            case .email:
                inputField.keyboardType = .emailAddress
            case .password:
                inputField.isSecureTextEntry = true
            case .userName:
                inputField.keyboardType = .namePhonePad
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updateStr = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        delegate?.userDidEnterData(in: self, field: textField, type: entry, data: updateStr)
        return true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.inputField.delegate = self
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
