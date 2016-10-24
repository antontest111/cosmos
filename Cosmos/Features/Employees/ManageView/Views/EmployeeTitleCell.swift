//
//  EmployeeTitleCell.swift
//  Cosmos
//
//  Created by Anton Selyanin on 24/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

class EmployeeTitleCell: UITableViewCell, ConfigurableCell {
    @IBOutlet var titleLabel: UILabel!
    
    func configure(item type: EmployeeType) {
        titleLabel.text = {
            switch type {
            case .manager: return "Manager"
            case .worker: return "Worker"
            case .accountant: return "Accountant"
            }
        }()
    }
}
