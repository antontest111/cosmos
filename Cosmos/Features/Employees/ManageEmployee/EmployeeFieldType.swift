//
//  EmployeeFieldType.swift
//  Cosmos
//
//  Created by Anton Selyanin on 23/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation

enum EmployeeFieldType: Int {
    case firstName
    case lastName
    case salary
    
    case receptionHours
    
    case placeNumber
    case lunchTime
    
    case accountantType
}

extension EmployeeFieldType {
    var title: String {
        switch self {
        case .firstName: return "First Name"
        case .lastName: return "Last Name"
        case .salary: return "Salary"
        case .receptionHours: return "Reception Hours"
        case .placeNumber: return "Place"
        case .lunchTime: return "Lunch Time"
        case .accountantType: return "Accountant Type"
        }
    }
}

private let commonFields: Set<EmployeeFieldType> = [.firstName, .lastName, .salary]
func isCommonField(_ field: EmployeeFieldType) -> Bool {
    return commonFields.contains(field)
}
