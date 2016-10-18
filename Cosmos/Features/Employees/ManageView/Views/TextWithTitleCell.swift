//
//  TextWithTitleCell.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

extension EmployeeFieldType {
    var title: String {
        switch self {
        case .firstName:
            return "First Name"
        case .lastName:
            return "Last Name"
            
        case .salary:
            return "Salary"
            
        default:
            return "UNEXPECTED"
        }
    }
}

class TextWithTitleCell: UITableViewCell {
    fileprivate var viewModel: EmployeeFieldViewModel?
    
    let titleLabel: UILabel = with(UILabel()) {
        $0.textAlignment = .right
    }
    
    let valueField: UILabel = with(UILabel()) {
        $0.textAlignment = .left
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueField)
        
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        titleLabel.autoPinEdge(toSuperviewEdge: .left)
        titleLabel.autoSetDimension(.width, toSize: 100)
        
        valueField.autoAlignAxis(.horizontal, toSameAxisOf: titleLabel)
        valueField.autoPinEdge(.left, to: .right, of: titleLabel, withOffset: 20)
        valueField.autoPinEdge(toSuperviewEdge: .right)
    }
}

extension TextWithTitleCell: ConfigurableCell {
    func configure(item: EmployeeFieldViewModel) {
        self.viewModel = item
        titleLabel.text = item.type.title
        valueField.text = item.value
    }
}
