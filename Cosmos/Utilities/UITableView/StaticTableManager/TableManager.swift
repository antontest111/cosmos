//
//  TableManager.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

class TableManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: TableManagerDelegate?
    
    fileprivate var sections: [TableSection] = []
    fileprivate let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        
        super.init()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
        row.configure(cell: cell)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
}

extension TableManager {
    func setSection(rows: [Row]) {
        sections = [TableSection(rows: rows)]
        tableView.reloadData()
    }
    
    func append(section: TableSection) {
        sections.append(section)
    }
}
