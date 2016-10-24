//
//  TextWithTitleCell2.swift
//  Cosmos
//
//  Created by Anton Selyanin on 24/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

class TextWithTitleCell: UITableViewCell {
    fileprivate var viewModel: EmployeeFieldViewModel?

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
}

extension TextWithTitleCell: ConfigurableCell {
    func configure(item: EmployeeFieldViewModel) {
        self.viewModel = item
        titleLabel.text = item.type.title
        valueLabel.text = item.stringValue
    }
}
