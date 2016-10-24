//
//  EditTextWithTitleCell.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class EditTextWithTitleCell: UITableViewCell {
    fileprivate var item: EmployeeFieldViewModel?
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueField: UITextField!
}

extension EditTextWithTitleCell: ConfigurableCell {
    func configure(item: EmployeeFieldViewModel) {
        self.item = item
        
        titleLabel.text = item.type.title
        valueField.text = item.stringValue
    }
}

extension EditTextWithTitleCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.item?.stringValue = textField.text ?? ""
    }
}
