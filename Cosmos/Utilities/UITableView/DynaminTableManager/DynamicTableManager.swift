//
//  DynamicTableManager.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

class DynamicTableManager<Section, Row, Cell: ConfigurableCell, Header: ConfigurableCell>
        : NSObject, UITableViewDataSource, UITableViewDelegate
        where Cell.Item == Row, Header.Item == Section {
    
    weak var delegate: TableManagerDelegate?
    
    fileprivate let tableView: UITableView
    fileprivate let dataSource: DataSource<Section, Row>
    
    init(tableView: UITableView, dataSource: DataSource<Section, Row>) {
        self.tableView = tableView
        self.dataSource = dataSource
        
        super.init()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.rowsCount(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath)
        
        if let configurableCell = cell as? Cell {
            let row = dataSource.row(for: indexPath)
            configurableCell.configure(item: row)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.sectionsCount
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return dataSource.canMoveRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataSource.moveRow(from: sourceIndexPath, to: destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return dataSource.validatedIndexPath(forSource: sourceIndexPath, target: proposedDestinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath:
        IndexPath) {
        
        switch editingStyle {
        case .delete:
            dataSource.delete(rowAt: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource.selectedRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: Header.reuseIdentifier)
        
        if let header = view as? Header {
            let sectionItem = dataSource.section(at: section)
            header.configure(item: sectionItem)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Header.preferredHeight
    }
}
