//
//  QuoteTableCell.swift
//  Cosmos
//
//  Created by Anton Selyanin on 17/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

class QuoteTableCell: UITableViewCell {
    @IBOutlet fileprivate var idLabel: UILabel!
    @IBOutlet fileprivate var dateLabel: UILabel!
    @IBOutlet fileprivate var quoteLabel: UILabel!
}

extension QuoteTableCell: ConfigurableCell {
    func configure(item: Quote) {
        idLabel.text = item.id
        dateLabel.text = item.date
        quoteLabel.text = item.text
    }
}
