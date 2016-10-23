//
//  RealmEmployee.swift
//  Cosmos
//
//  Created by Anton Selyanin on 22/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import RealmSwift

typealias UniqueId = String

class ListItem: Object {
    dynamic var order: Int32 = 0
//    dynamic var employee: Employee2? = nil
//    let employees: List<Employee2> = List()
}

class Person: Object {
    dynamic var uid: UniqueId = UUID().uuidString
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

protocol Employee2: class {
    var uid: UniqueId { get }

    var person: Person? { get set }
    
    var type: EmployeeType { get }
    
    var salary: Money { get set }
}

protocol WorkerProtocol: Employee2 {
    var attributes: WorkerAttributes? { get set }
}

protocol AccountantProtocol: WorkerProtocol {
    var accountantType: AccountantType { get set }
}

//////////////////////

class Manager: Object, Employee2 {
    dynamic var uid: UniqueId = UUID().uuidString
    dynamic var person: Person?
    let type: EmployeeType = .manager
    dynamic var salary: Money = 0
    
    dynamic var receptionHours: Time = ""
    
    override static func primaryKey() -> String? {
        return "uid"
    }
}

class Worker: Object, WorkerProtocol {
    dynamic var uid: UniqueId = UUID().uuidString
    dynamic var person: Person?
    let type: EmployeeType = .worker
    dynamic var salary: Money = 0
    
    dynamic var attributes: WorkerAttributes?

    override static func primaryKey() -> String? {
        return "uid"
    }
}

class Accountant: Object, AccountantProtocol {
    dynamic var uid: UniqueId = UUID().uuidString
    dynamic var person: Person?
    let type: EmployeeType = .accountant
    dynamic var salary: Money = 0

    dynamic var attributes: WorkerAttributes?
    dynamic var accountantType: AccountantType = ""

    override static func primaryKey() -> String? {
        return "uid"
    }
}

////////////////////

class WorkerAttributes: Object {
    dynamic var placeNumber: PlaceNumber = ""
    dynamic var lunchTime: Time = ""
}
