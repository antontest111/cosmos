//
//  EmpoyeesHeaderView.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import PureLayout

class EmployeesTableHeader: UITableViewHeaderFooterView, ConfigurableCell {
    private let customLabel: UILabel = UILabel()

    static var preferredHeight: CGFloat {
        return 30
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(customLabel)
        customLabel.autoPinEdgesToSuperviewEdges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: EmployeeType) {
        customLabel.text = String(describing: item)
    }
}
