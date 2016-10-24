//
//  RealmEmployee.swift
//  Cosmos
//
//  Created by Anton Selyanin on 22/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import RealmSwift

class EmployeeObject: Object, Indexable {
    dynamic var uid: UniqueId = UUID().uuidString
    dynamic var person: Person?
    dynamic var salary: Money = 0
    dynamic var index: Int = 0

    override static func primaryKey() -> String? {
        return "uid"
    }
}

class Manager: EmployeeObject, ManagerProtocol {
    var type: EmployeeType {
        return .manager
    }
    
    dynamic var receptionHours: Time = ""
}

class Worker: EmployeeObject, WorkerProtocol {
    var type: EmployeeType {
        return .worker
    }

    dynamic var placeNumber: PlaceNumber = ""
    dynamic var lunchTime: Time = ""
}

class Accountant: Worker, AccountantProtocol {
    override var type: EmployeeType {
        return .accountant
    }

    var accountantType: AccountantType {
        get {
            return AccountantType(rawValue: accountantTypeRaw) ?? .payroll
        }
        set {
            accountantTypeRaw = newValue.rawValue
        }
    }
    dynamic var accountantTypeRaw: Int = AccountantType.payroll.rawValue
}

class Person: Object {
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
