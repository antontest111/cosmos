//
//  Employee.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation

//struct Employee {
//    let id: Int
//    
//    var personID: PersonID
//    var salary: Money
//    var role: EmployeeRole
//    
//    var type: EmployeeType {
//        switch role {
//        case .manager:
//            return .manager
//        
//        case .worker(_, _, .simple):
//            return .worker
//        
//        case .worker(_, _, .accountant):
//            return .accountant
//        }
//    }
//}
//
//struct PersonID {
//    var firstName: String
//    var lastName: String
//    
//    var fullName: String {
//        return "\(firstName) \(lastName)"
//    }
//}
//
//enum EmployeeRole {
//    case manager(receptionHours: Time)
//    case worker(placeNumber: PlaceNumber, lunchTime: Time, type: WorkerType)
//}
//
//enum WorkerType {
//    case simple
//    case accountant(AccountantType)
//}

enum EmployeeType: Int {
    case manager = 0
    case worker
    case accountant
    
    static var values: [EmployeeType] = [.manager, .worker, .accountant]
}

typealias Money = Int
typealias PlaceNumber = String
typealias Time = String
typealias AccountantType = String
