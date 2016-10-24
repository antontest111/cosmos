//
//  AccountantTypeCell.swift
//  Cosmos
//
//  Created by Anton Selyanin on 24/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

class AccountantTypeSelectorCell: UITableViewCell {
    fileprivate var viewModel: EmployeeFieldViewModel?
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentChanged() {
        viewModel?.intValue = segmentedControl.selectedSegmentIndex
    }
}

extension AccountantTypeSelectorCell: ConfigurableCell {
    func configure(item viewModel: EmployeeFieldViewModel) {
        self.viewModel = viewModel
        segmentedControl.selectedSegmentIndex = viewModel.intValue
    }
}
