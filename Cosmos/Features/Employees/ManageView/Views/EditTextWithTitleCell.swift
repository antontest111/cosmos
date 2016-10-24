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
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setup()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    private func setup() {
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(valueField)
//        
//        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
//        titleLabel.autoPinEdge(toSuperviewEdge: .left)
//        titleLabel.autoSetDimension(.width, toSize: 100)
//        
//        valueField.autoAlignAxis(.horizontal, toSameAxisOf: titleLabel)
//        valueField.autoPinEdge(.left, to: .right, of: titleLabel, withOffset: 20)
//        valueField.autoPinEdge(toSuperviewEdge: .right)
//        valueField.delegate = self
//    }
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


//class EditTextWithTitleCell: UITableViewCell {
//    fileprivate var item: EmployeeFieldViewModel?
//    
//    let titleLabel: UILabel = with(UILabel()) {
//        $0.textAlignment = .right
//    }
//    
//    let valueField: UITextField = with(UITextField()) {
//        $0.textAlignment = .left
//    }
//    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setup()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setup() {
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(valueField)
//        
//        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
//        titleLabel.autoPinEdge(toSuperviewEdge: .left)
//        titleLabel.autoSetDimension(.width, toSize: 100)
//        
//        valueField.autoAlignAxis(.horizontal, toSameAxisOf: titleLabel)
//        valueField.autoPinEdge(.left, to: .right, of: titleLabel, withOffset: 20)
//        valueField.autoPinEdge(toSuperviewEdge: .right)
//        valueField.delegate = self
//    }
//}
//
//extension EditTextWithTitleCell: ConfigurableCell {
//    func configure(item: EmployeeFieldViewModel) {
//        self.item = item
//        
//        titleLabel.text = item.type.title
//        valueField.text = item.value
//    }
//}
//
//extension EditTextWithTitleCell: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        self.item?.value = textField.text ?? ""
//    }
//}
