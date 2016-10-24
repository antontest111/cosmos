//
//  DataSource.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation

/// Type erasure for DataSourceProtocol
class DataSource<Section, Row>: DataAccessProtocol {
    private let dataAccess: DataAccessProtocol
    private let readRow: (IndexPath) -> Row
    private let readSection: (Int) -> Section
    
    init<DS: DataSourceProtocol> (dataSource: DS) where DS.Section == Section, DS.Row == Row {
        self.dataAccess = dataSource
        readRow = { dataSource.row(for: $0) }
        readSection = { dataSource.section(at: $0) }
    }
    
    var sectionsCount: Int {
        return dataAccess.sectionsCount
    }
    
    func section(at index: Int) -> Section {
        return readSection(index)
    }
    
    func rowsCount(in sectionIndex: Int) -> Int {
        return dataAccess.rowsCount(in: sectionIndex)
    }
    
    func row(for indexPath: IndexPath) -> Row {
        return readRow(indexPath)
    }
    
    func delete(rowAt indexPath: IndexPath) {
        dataAccess.delete(rowAt: indexPath)
    }
    
    func canMoveRow(at indexPath: IndexPath) -> Bool {
        return dataAccess.canMoveRow(at: indexPath)
    }
    
    func moveRow(from fromIndex: IndexPath, to toIndex: IndexPath) {
        dataAccess.moveRow(from: fromIndex, to: toIndex)
    }

    func validatedIndexPath(forSource source: IndexPath, target: IndexPath) -> IndexPath {
        return dataAccess.validatedIndexPath(forSource: source, target: target)
    }
    
    func selectedRow(at indexPath: IndexPath) {
        return dataAccess.selectedRow(at: indexPath)
    }
}

protocol DataAccessProtocol {
    var sectionsCount: Int { get }
    
    func rowsCount(in sectionIndex: Int) -> Int
    
    func delete(rowAt indexPath: IndexPath)
    
    func canMoveRow(at indexPath: IndexPath) -> Bool
    
    func moveRow(from: IndexPath, to: IndexPath)
    
    func validatedIndexPath(forSource source: IndexPath, target: IndexPath) -> IndexPath
    
    func selectedRow(at: IndexPath)
}

protocol DataSourceProtocol: DataAccessProtocol {
    associatedtype Section
    associatedtype Row
    
    func section(at: Int) -> Section
    
    func row(for indexPath: IndexPath) -> Row
}

