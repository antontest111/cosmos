//
//  TableSection.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

class TableSection {
    private(set) var rows: [Row]
    
    init(rows: [Row] = []) {
        self.rows = rows
    }
    
    func append(row: Row) {
        rows.append(row)
    }
}
