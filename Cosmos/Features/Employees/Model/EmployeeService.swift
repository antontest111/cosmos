//
//  EmployeeService.swift
//  Cosmos
//
//  Created by Anton Selyanin on 23/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import RealmSwift

protocol EmployeeListService2: class {
    weak var listener: EmployeeListServiceListener? { get set }
    
    var sectionsCount: Int { get }
    
    func employeesCount(section: Int) -> Int
    
    func employee(at indexPath: IndexPath) -> Employee2
    
    func employeeType(at index: Int) -> EmployeeType
    
    func delete(at indexPath: IndexPath)
    
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath)
}

protocol EmployeeListServiceListener: class {
    func reloadData()
}

class EmployeeService2: EmployeeListService2 {
    weak var listener: EmployeeListServiceListener?
    
    private let realm: Realm
    private let employees: [EmployeeResults]
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
            self?.listener?.reloadData()
        }
    }
    
    var sectionsCount: Int {
        return employees.count
    }
    
    func employeesList(section: Int) -> [Employee2] {
        fatalError()
    }
    
    func employeesCount(section: Int) -> Int {
        return employees[section].count
    }
    
    func employee(at indexPath: IndexPath) -> Employee2 {
        return employees[indexPath.section][indexPath.item]
    }
    
    func employeeType(at index: Int) -> EmployeeType {
        return employees[index].employeeType
    }
    
    func delete(at indexPath: IndexPath) {
        
    }
    
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        
    }
}


/// Type erasure for Realm.Results
private class EmployeeResults {
    let employeeType: EmployeeType
    private let readCount: () -> Int
    private let readEmployee: (Int) -> Employee2
    
    init<E: Object>(type: EmployeeType, results: Results<E>) where E: Employee2 {
        self.readCount = { results.count }
        self.readEmployee = { results[$0] }
        self.employeeType = type
    }
    
    var count: Int {
        return readCount()
    }
    
    public subscript(position: Int) -> Employee2 {
        return readEmployee(position)
    }
}
