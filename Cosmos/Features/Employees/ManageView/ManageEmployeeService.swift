//
//  ManageEmployeeService.swift
//  Cosmos
//
//  Created by Anton Selyanin on 23/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import RealmSwift

class EmployeeFieldViewModel {
    let type: EmployeeFieldType
    var value: String
    
    init(type: EmployeeFieldType, value: String) {
        self.type = type
        self.value = value
    }
}

protocol ManageEmployeeServiceProtocol {
    var employeeType: EmployeeType { get }
    
    func fields() -> [[EmployeeFieldViewModel]]
    
    func save(fields: [EmployeeFieldViewModel])
}

class ManageEmployeeService2: ManageEmployeeServiceProtocol {
    private let realm: Realm
    private let employee: Employee2
    
    init(employee: Employee2, realm: Realm) {
        self.employee = employee
        self.realm = realm
    }
    
    var employeeType: EmployeeType {
        return employee.type
    }
    
    func fields() -> [[EmployeeFieldViewModel]] {
        var fields = [[
            EmployeeFieldViewModel(type: .firstName, value: employee.person?.firstName ?? ""),
            EmployeeFieldViewModel(type: .lastName, value: employee.person?.lastName ?? ""),
            EmployeeFieldViewModel(type: .salary, value: String(describing: employee.salary))
        ]]
        
        switch employee {
        case let object as Manager:
            fields.append(readFields(for: object))
            
        case let object as Worker:
            fields.append(readFields(for: object))
            
        case let object as Accountant:
            fields.append(readFields(for: object))
            
        default:
            break
        }
        
        return fields
    }
    
    private func readFields(for manager: Manager) -> [EmployeeFieldViewModel] {
        return [
            EmployeeFieldViewModel(type: .receptionHours, value: manager.receptionHours)
        ]
    }
    
    private func readFields(for worker: WorkerProtocol) -> [EmployeeFieldViewModel] {
        return [
            EmployeeFieldViewModel(type: .placeNumber, value: worker.attributes?.placeNumber ?? ""),
            EmployeeFieldViewModel(type: .lunchTime, value: worker.attributes?.lunchTime ?? "")
        ]
    }
    
    private func readFields(for accountant: AccountantProtocol) -> [EmployeeFieldViewModel] {
        return readFields(for: accountant as WorkerProtocol) + [
            EmployeeFieldViewModel(type: .accountantType, value: accountant.accountantType)
        ]
    }
    
    func save(fields: [EmployeeFieldViewModel]) {
        try! realm.write {
            for field in fields {
                switch field.type {
                case .firstName:
                    employee.person?.firstName = field.value
                    
                case .lastName:
                    employee.person?.lastName = field.value
                    
                default:
                    break
                }
            }
        }
    }
}
