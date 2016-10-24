//
//  EmployeeService.swift
//  Cosmos
//
//  Created by Anton Selyanin on 23/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import RealmSwift

protocol EmployeeDataService: class {
    func createEmployee(ofType: EmployeeType) -> Employee
    
    func remove(employee: Employee)
    
    func createIfNotPresent(employee: Employee)
}

protocol EmployeeListService: class {
    weak var listener: EmployeeListServiceListener? { get set }
    
    var sectionsCount: Int { get }
    
    func employeesCount(section: Int) -> Int
    
    func employee(at indexPath: IndexPath) -> Employee
    
    func employeeType(at index: Int) -> EmployeeType
    
    func delete(at indexPath: IndexPath)
    
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath)
}

protocol EmployeeListServiceListener: class {
    func reloadData()
}

class EmployeeService: EmployeeListService {
    weak var listener: EmployeeListServiceListener?
    
    fileprivate let realm: Realm
    fileprivate let employees: [EmployeeResults]
    private var notificationToken: NotificationToken?
    
    init(realm: Realm) {
        self.realm = realm
        
        let managers = realm.objects(Manager.self)
        let accountants = realm.objects(Accountant.self)
        let workers = realm.objects(Worker.self)
        
        self.employees = [
            EmployeeResults(type: .manager, results: managers),
            EmployeeResults(type: .worker, results: workers),
            EmployeeResults(type: .accountant, results: accountants)
        ]

        notificationToken = realm.addNotificationBlock { [weak self] _ in
            DispatchQueue.main.async {
                self?.listener?.reloadData()
            }
        }
    }
    
    var sectionsCount: Int {
        return employees.count
    }
    
    func employeesCount(section: Int) -> Int {
        return employees[section].count
    }
    
    func employee(at indexPath: IndexPath) -> Employee {
        return employees[indexPath.section][indexPath.item]
    }
    
    func employeeType(at index: Int) -> EmployeeType {
        return employees[index].employeeType
    }
    
    func delete(at indexPath: IndexPath) {
        guard let object = employee(at: indexPath) as? Object else { return }
        
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        precondition(fromIndexPath.section == toIndexPath.section)
        
        let section = employees[toIndexPath.section]
        
        let from = fromIndexPath.row
        let to = toIndexPath.row
        
        let target = section[from]
        let toIndex = section[to].index

        let range = from > to ? (to..<from) : ((from + 1)..<(to + 1))
        let delta = from > to ? 1 : -1
        
        try! realm.write {
            for index in range {
                let item = section[index]
                item.index = item.index + delta
            }
            
            target.index = toIndex
        }
    }
}


extension EmployeeService: EmployeeDataService {
    func createEmployee(ofType type: EmployeeType) -> Employee {
        switch type {
        case .manager:
            return Manager()
            
        case .worker:
            return Worker()
            
        case .accountant:
            return Accountant()
        }
    }
    
    func remove(employee: Employee) {
        guard let object = employee as? EmployeeObject, isExisting(employee: employee) else { return }
        realm.delete(object)
    }
    
    func createIfNotPresent(employee: Employee) {
        guard let object = employee as? EmployeeObject, !isExisting(employee: employee) else { return }
        
        let lastIndex = employees[employee.type.rawValue].last?.index ?? -1
        object.index = lastIndex + 1
        
        realm.add(object)
    }
    
    private func isExisting(employee: Employee) -> Bool {
        switch employee {
        case is Manager:
            return realm.object(ofType: Manager.self, forPrimaryKey: employee.uid) != nil
            
        case is Accountant:
            return realm.object(ofType: Accountant.self, forPrimaryKey: employee.uid) != nil

        case is Worker:
            return realm.object(ofType: Worker.self, forPrimaryKey: employee.uid) != nil

        default:
            return false
        }
    }
}

/// Type erasure for RealmSwift.Results
private class EmployeeResults {
    let employeeType: EmployeeType
    private let readCount: () -> Int
    private let readEmployee: (Int) -> Employee
    private let readLast: () -> Employee?
    
    init<E: Object>(type: EmployeeType, results: Results<E>) where E: Employee {
        let sorterResult = results
            .sorted(byProperty: "index")
        
        self.readCount = { sorterResult.count }
        self.readEmployee = { sorterResult[$0] }
        self.readLast = { sorterResult.last  }
        
        self.employeeType = type
    }
    
    var count: Int {
        return readCount()
    }
    
    subscript(position: Int) -> Employee {
        return readEmployee(position)
    }
    
    var last: Employee? {
        return readLast()
    }
}
