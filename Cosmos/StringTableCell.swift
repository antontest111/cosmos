//
//  StringTableCell.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

typealias StringTableCell = CustomStringTableCell<String>

class CustomStringTableCell<Item: CustomStringConvertible>: UITableViewCell, ConfigurableCell {
    func configure(item: Item) {
        textLabel?.text = item.description
    }
}
