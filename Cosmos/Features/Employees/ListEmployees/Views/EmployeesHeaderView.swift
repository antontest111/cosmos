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
    private let titleLabel: UILabel = UILabel()
    private let imageView: UIImageView = with(UIImageView()) {
        $0.contentMode = .scaleAspectFit
    }

    static let preferredHeight: CGFloat = 30

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.addSubview(imageView)
        imageView.autoPinEdge(toSuperviewMargin: .left)
        imageView.autoSetDimensions(to: CGSize(width: 20, height: 20))
        imageView.autoAlignAxis(toSuperviewAxis: .horizontal)

        contentView.addSubview(titleLabel)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        titleLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: 10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: EmployeeType) {
        switch item {
        case .manager:
            imageView.image = UIImage(named: "manager")
            titleLabel.text = "Managers"
            
        case .worker:
            imageView.image = UIImage(named: "worker")
            titleLabel.text = "Workers"
            
        case .accountant:
            imageView.image = UIImage(named: "accountant")
            titleLabel.text = "Accountants"
        }
    }
}
