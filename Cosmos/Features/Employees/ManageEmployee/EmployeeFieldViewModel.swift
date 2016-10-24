//
//  EmployeeFieldViewModel.swift
//  Cosmos
//
//  Created by Anton Selyanin on 24/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation

class EmployeeFieldViewModel {
    enum Value {
        case string(String)
        case int(Int)
    }
    
    var value: Value
    
    let type: EmployeeFieldType
    
    var stringValue: String {
        get {
            guard case .string(let string) = value else { return "" }
            return string
        }
        set {
            value = .string(newValue)
        }
    }
    
    var intValue: Int {
        get {
            guard case .int(let int) = value else { return 0 }
            return int
        }
        set {
            value = .int(newValue)
        }
    }
    
    convenience init(type: EmployeeFieldType, value: String) {
        self.init(type: type, value: .string(value))
    }

    convenience init(type: EmployeeFieldType, value: Int) {
        self.init(type: type, value: .int(value))
    }
    
    init(type: EmployeeFieldType, value: Value) {
        self.type = type
        self.value = value
    }
}
