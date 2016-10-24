//
//  Employee.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation

enum EmployeeType: Int {
    case manager = 0
    case worker
    case accountant
    
    static var values: [EmployeeType] = [.manager, .worker, .accountant]
}

protocol Indexable: class {
    var index: Int { get set }
}

protocol Employee: class, Indexable {
    var uid: UniqueId { get }
    var person: Person? { get set }
    var type: EmployeeType { get }
    var salary: Money { get set }
    
    static func primaryKey() -> String?
}

protocol ManagerProtocol: Employee {
    var receptionHours: Time { get set }
}

protocol WorkerProtocol: Employee {
    var placeNumber: PlaceNumber { get set }
    var lunchTime: Time { get set }
}

protocol AccountantProtocol: WorkerProtocol {
    var accountantType: AccountantType { get set }
}

enum AccountantType: Int {
    case payroll
    case products
}

typealias Money = Int
typealias PlaceNumber = String
typealias Time = String
typealias UniqueId = String
