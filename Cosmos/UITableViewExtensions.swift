//
//  UITableViewExtensions.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register(cell: ReusableView.Type) {
        register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }

    func register(nib cellType: ReusableView.Type) {
        register(UINib(nibName: String(describing: cellType), bundle: nil),
                 forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    func register(header: ReusableView.Type) {
        register(header, forHeaderFooterViewReuseIdentifier: header.reuseIdentifier)
    }
}
