//
//  AccountantTypeCell.swift
//  Cosmos
//
//  Created by Anton Selyanin on 24/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

class AccountantTypeCell: UITableViewCell, ConfigurableCell {
    @IBOutlet var typeLabel: UILabel!
    
    func configure(item type: Int) {
        typeLabel.text = {
            let accountantType = AccountantType(rawValue: type) ?? .payroll
            switch accountantType {
            case .payroll:
                return "Payroll"
                
            case .products:
                return "Products"
            }
        }()
    }
}
