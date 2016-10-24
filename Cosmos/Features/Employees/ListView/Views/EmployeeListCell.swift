//
//  EmployeeListCell.swift
//  Cosmos
//
//  Created by Anton Selyanin on 24/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

class EmployeeListCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
}

extension EmployeeListCell: ConfigurableCell {
    func configure(item: EmployeeInfo) {
        nameLabel.text = item.name
        detailsLabel.text = item.details
    }
}
