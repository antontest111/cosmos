//
//  EmployeeListService.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation

protocol EmployeeListService {
    var sectionsCount: Int { get }
    
    func employeesList(section: Int) -> [Employee]
    
    func employeesCount(section: Int) -> Int
    
    func employee(at indexPath: IndexPath) -> Employee
    
    func employeeType(at index: Int) -> EmployeeType
    
    func delete(at indexPath: IndexPath)
    
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath)
}

protocol ManageEmployeeService {
    func save(employee: Employee)
}

class EmployeeService: EmployeeListService {
    fileprivate var employees: [(EmployeeType, [Employee])] = [
        (.manager, [
            Employee(id: 1,
                     personID: PersonID(firstName: "John", lastName: "Smith"),
                     salary: 100,
                     role: .manager(receptionHours: "8-10")),
            Employee(id: 2,
                     personID: PersonID(firstName: "Jane", lastName: "Morgan"),
                     salary: 100,
                     role: .manager(receptionHours: "8-10")),
            Employee(id: 3,
                     personID: PersonID(firstName: "Harry", lastName: "Davis"),
                     salary: 100,
                     role: .manager(receptionHours: "8-10")),
            ]),
        
        (.simpleWorker, [
            Employee(id: 1,
                     personID: PersonID(firstName: "John", lastName: "Smith"),
                     salary: 100,
                     role: .worker(placeNumber: "1", lunchTime: "5-7", type: .simple)),
            Employee(id: 1,
                     personID: PersonID(firstName: "John", lastName: "Smith"),
                     salary: 100,
                     role: .worker(placeNumber: "1", lunchTime: "5-7", type: .simple)),
            Employee(id: 1,
                     personID: PersonID(firstName: "John", lastName: "Smith"),
                     salary: 100,
                     role: .worker(placeNumber: "1", lunchTime: "5-7", type: .simple)),
            ]),
        
        ]

    var sectionsCount: Int {
        return employees.count
    }
    
    func employeesList(section: Int) -> [Employee] {
        return employees[section].1
    }
    
    func employeesCount(section: Int) -> Int {
        return employeesList(section: section).count
    }
    
    func employee(at indexPath: IndexPath) -> Employee {
        return employeesList(section: indexPath.section)[indexPath.row]
    }
    
    func employeeType(at index: Int) -> EmployeeType {
        return employees[index].0
    }
    
    func delete(at indexPath: IndexPath) {
        employees[indexPath.section].1.remove(at: indexPath.row)
    }
    
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        precondition(fromIndexPath.section == toIndexPath.section)
        let section = toIndexPath.section
        let from = fromIndexPath.row
        let to = toIndexPath.row
        
        var list = employeesList(section: section)
        
        let employee = list[from]
        list.remove(at: from)
        list.insert(employee, at: to)
    }
}

extension EmployeeService: ManageEmployeeService {
    func save(employee: Employee) {
        
    }
}
