//
//  ManageEmployeeService.swift
//  Cosmos
//
//  Created by Anton Selyanin on 23/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import RealmSwift

protocol ManageEmployeeServiceProtocol {
    var employeeType: EmployeeType { get }
    
    func commonFields() -> [EmployeeFieldViewModel]

    func typeFields(of type: EmployeeType) -> [EmployeeFieldViewModel]

    func save(type: EmployeeType, fields: [EmployeeFieldViewModel])
}

class ManageEmployeeService2: ManageEmployeeServiceProtocol {
    private let realm: Realm
    private var employee: Employee
    private let dataService: EmployeeDataService
    
    init(employee: Employee, realm: Realm, dataService: EmployeeDataService) {
        self.employee = employee
        self.realm = realm
        self.dataService = dataService
    }
    
    var employeeType: EmployeeType {
        return employee.type
    }
    
    func commonFields() -> [EmployeeFieldViewModel] {
        return [
            EmployeeFieldViewModel(type: .firstName, value: employee.person?.firstName ?? ""),
            EmployeeFieldViewModel(type: .lastName, value: employee.person?.lastName ?? ""),
            EmployeeFieldViewModel(type: .salary, value: String(describing: employee.salary))
        ]
    }
    
    func typeFields(of type: EmployeeType) -> [EmployeeFieldViewModel] {
        guard employeeType != type else {
            return typeFields()
        }
        
        // TODO: eliminate code duplication
        switch type {
        case .manager:
            return [
                EmployeeFieldViewModel(type: .receptionHours, value: "")
            ]
            
        case .worker:
            return [
                EmployeeFieldViewModel(type: .placeNumber, value: ""),
                EmployeeFieldViewModel(type: .lunchTime, value: "")
            ]

        case .accountant:
            return [
                EmployeeFieldViewModel(type: .placeNumber, value: ""),
                EmployeeFieldViewModel(type: .lunchTime, value: ""),
                EmployeeFieldViewModel(type: .accountantType, value: AccountantType.payroll.rawValue)
            ]
        }
    }

    private func typeFields() -> [EmployeeFieldViewModel] {
        switch employee {
        case let object as ManagerProtocol:
            return readFields(for: object)

        case let object as AccountantProtocol:
            return readFields(for: object)

        case let object as WorkerProtocol:
            return readFields(for: object)
            
        default:
            return []
        }
    }
    
    private func readFields(for manager: ManagerProtocol) -> [EmployeeFieldViewModel] {
        return [
            EmployeeFieldViewModel(type: .receptionHours, value: manager.receptionHours)
        ]
    }
    
    private func readFields(for worker: WorkerProtocol) -> [EmployeeFieldViewModel] {
        return [
            EmployeeFieldViewModel(type: .placeNumber, value: worker.placeNumber),
            EmployeeFieldViewModel(type: .lunchTime, value: worker.lunchTime)
        ]
    }
    
    private func readFields(for accountant: AccountantProtocol) -> [EmployeeFieldViewModel] {
        return readFields(for: accountant as WorkerProtocol) + [
            EmployeeFieldViewModel(type: .accountantType, value: accountant.accountantType.rawValue)
        ]
    }
    
    func save(type: EmployeeType, fields: [EmployeeFieldViewModel]) {
        try! realm.write {
            if type != employee.type {
                changeEmployee(toType: type)
            }
            
            update(fields)
        }
    }
    
    private func changeEmployee(toType type: EmployeeType) {
        let person = employee.person
        let salary = employee.salary
        
        dataService.remove(employee: employee)
        employee = dataService.createEmployee(ofType: type)
        
        employee.person = person ?? Person()
        employee.salary = salary
    }
    
    private func createEmployee<T: Object>(_ object: T) -> T {
        realm.add(object)
        return object
    }
    
    private func update(_ fields: [EmployeeFieldViewModel]) {
        for field in fields {
            switch field.type {
            case .firstName:
                employee.person?.firstName = field.stringValue
                
            case .lastName:
                employee.person?.lastName = field.stringValue
                
            case .salary:
                employee.salary = Int(field.stringValue) ?? 0
            
            case .receptionHours:
                if let manager = employee as? ManagerProtocol {
                    manager.receptionHours = field.stringValue
                }
                
            case .placeNumber:
                if let worker = employee as? WorkerProtocol {
                    worker.placeNumber = field.stringValue
                }
                
            case .lunchTime:
                if let worker = employee as? WorkerProtocol {
                    worker.lunchTime = field.stringValue
                }
                
            case .accountantType:
                if let accountant = employee as? AccountantProtocol {
                    accountant.accountantType = AccountantType(rawValue: field.intValue) ?? .payroll
                }
            }
        }
        
        dataService.createIfNotPresent(employee: employee)
    }
}
