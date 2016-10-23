//
//  EmployeeTypeSelectorCell.swift
//  Cosmos
//
//  Created by Anton Selyanin on 23/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

protocol EmployeeTypeSelectorDelegate: class {
    var employeeType: EmployeeType { get set }
}

class EmployeeTypeSelectorCell: UITableViewCell {
    fileprivate weak var delegate: EmployeeTypeSelectorDelegate?
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentChanged() {
        guard let type = EmployeeType(rawValue: segmentedControl.selectedSegmentIndex) else { return }
        
        delegate?.employeeType = type
    }
}

extension EmployeeTypeSelectorCell: ConfigurableCell {
    func configure(item: EmployeeTypeSelectorDelegate) {
        self.delegate = item
        segmentedControl.selectedSegmentIndex = item.employeeType.rawValue
    }
}
