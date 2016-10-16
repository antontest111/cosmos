//
//  EmployeesListPresenter.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation


protocol EmployeesListViewProtocol: class {
    func setEditMode(enabled: Bool)
}

protocol EmployeesListPresenterProtocol: class {
    var dataSource: DataSource<EmployeeType, String> { get }
    
    func tappedAddNewEmployee()
}

protocol EmployeesListOutput: class {
    var selectedEmployee: ((Employee) -> Void)? { get }
    
    var addNewEmployee: (() -> Void)? { get }
}

class EmployeesListPresenter: EmployeesListPresenterProtocol, EmployeesListOutput {
    fileprivate let service: EmployeeListService
    private(set) lazy var dataSource: DataSource<EmployeeType, String> = DataSource(dataSource: self)
    
    var selectedEmployee: ((Employee) -> Void)?
    var addNewEmployee: (() -> Void)?
    
    init(service: EmployeeListService = EmployeeService()) {
        self.service = service
    }
    
    func tappedAddNewEmployee() {
        addNewEmployee?()
    }
}

extension EmployeesListPresenter: DataSourceProtocol {
    func section(at index: Int) -> EmployeeType {
        return service.employeeType(at: index)
    }
    
    func row(for indexPath: IndexPath) -> String {
        return service.employee(at: indexPath).personID.fullName
    }
    
    var sectionsCount: Int {
        return service.sectionsCount
    }
    
    func rowsCount(in sectionIndex: Int) -> Int {
        return service.employeesCount(section: sectionIndex)
    }
    
    func delete(rowAt indexPath: IndexPath) {
        service.delete(at: indexPath)
    }
    
    func moveRow(from: IndexPath, to: IndexPath) {
        service.move(from: from, to: to)
    }
    
    func canMoveRow(at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func selectedRow(at indexPath: IndexPath) {
        selectedEmployee?(service.employee(at: indexPath))
    }
    
    func validatedIndexPath(forSource source: IndexPath, target: IndexPath) -> IndexPath {
        guard source.section != target.section else { return target }
        
        if source.section > target.section {
            return IndexPath(row: 0, section: source.section)
        } else {
            return IndexPath(row: service.employeesCount(section: source.section) - 1, section: source.section)
        }
    }
}
