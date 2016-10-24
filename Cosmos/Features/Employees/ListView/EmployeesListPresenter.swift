//
//  EmployeesListPresenter.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation

protocol EmployeesListPresenterProtocol: class {
    var dataSource: DataSource<EmployeeType, EmployeeInfo> { get }
    
    func tappedAddNewEmployee()
    
    func bind(view: EmployeesListViewProtocol)
}

protocol EmployeesListOutput: class {
    var selectedEmployee: ((Employee) -> Void)? { get }
    
    var addNewEmployee: (() -> Void)? { get }
}

class EmployeesListPresenter: EmployeesListPresenterProtocol, EmployeesListOutput {
    fileprivate let service: EmployeeListService
    private(set) lazy var dataSource: DataSource<EmployeeType, EmployeeInfo> = DataSource(dataSource: self)
    fileprivate weak var view: EmployeesListViewProtocol?

    var selectedEmployee: ((Employee) -> Void)?
    var addNewEmployee: (() -> Void)?
    
    init(service: EmployeeListService) {
        self.service = service
        service.listener = self
    }
    
    func tappedAddNewEmployee() {
        addNewEmployee?()
    }
    
    func bind(view: EmployeesListViewProtocol) {
        self.view = view
        view.reloadData()
    }
}

extension EmployeesListPresenter: EmployeeListServiceListener {
    func reloadData() {
        view?.reloadData()
    }
}

extension EmployeesListPresenter: DataSourceProtocol {
    func section(at index: Int) -> EmployeeType {
        return service.employeeType(at: index)
    }
    
    func row(for indexPath: IndexPath) -> EmployeeInfo {
        let employee = service.employee(at: indexPath)
        
        return EmployeeInfo(name: employee.person?.fullName ?? "",
                            details: description(of: employee))
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

private func description(of employee: Employee) -> String {
    switch employee {
    case let manager as ManagerProtocol:
        return "Reception Hours: \(manager.receptionHours)"
        
    case let accountant as AccountantProtocol:
        return "\(workerDescription(accountant)), type: \(accountant.accountantType)"
        
    case let worker as WorkerProtocol:
        return workerDescription(worker)
        
    default:
        assertionFailure()
        return "UNEXPECTED"
    }
}

private func workerDescription(_ worker: WorkerProtocol) -> String {
    return "Place: \(worker.placeNumber), lunch: \(worker.lunchTime)"
}
