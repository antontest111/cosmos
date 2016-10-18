//
//  TableRow.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

protocol Row {
    var reuseIdentifier: String { get }
    
    func configure(cell: UITableViewCell)
}

class TableRow<Item, Cell: ConfigurableCell>: Row where Cell: UITableViewCell, Cell.Item == Item  {
    private let item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    var reuseIdentifier: String {
        return Cell.reuseIdentifier
    }
    
    func configure(cell: UITableViewCell) {
        guard let configurable = cell as? Cell else { return }
        
        configurable.configure(item: item)
    }
}
