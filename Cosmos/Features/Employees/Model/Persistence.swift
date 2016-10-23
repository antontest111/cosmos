//
//  Persistence.swift
//  Cosmos
//
//  Created by Anton Selyanin on 23/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import RealmSwift

class Persistence {
    static func setup() {
        var config = Realm.Configuration()
        
        config.fileURL = config.fileURL!.deletingLastPathComponent()
            .appendingPathComponent("Employees.realm")
        Realm.Configuration.defaultConfiguration = config
        
        setupData()
    }
    
    private static func setupData() {
        let realm = try! Realm()
        
        guard realm.objects(Person.self).isEmpty else { return  }
        
        let managers = [
            Manager(value: [generateId(), [generateId(), "Jane", "Manager1"], 100, "1-2"]),
            Manager(value: [generateId(), [generateId(), "Harry", "Manager2"], 100, "1-2"]),
            Manager(value: [generateId(), [generateId(), "Olivia", "Manager3"], 100, "1-2"]),
            Manager(value: [generateId(), [generateId(), "Martin", "Manager4"], 100, "1-2"])
        ]
        
        let workers = [
            Worker(value: [generateId(), [generateId(), "Helen", "Worker1"], 100, ["place 1", "12-13"]]),
            Worker(value: [generateId(), [generateId(), "Justin", "Worker2"], 100, ["place 2", "12-13"]]),
            Worker(value: [generateId(), [generateId(), "Mario", "Worker3"], 100, ["place 3", "12-13"]]),
            Worker(value: [generateId(), [generateId(), "Olga", "Worker4"], 100, ["place 4", "12-13"]]),
        ]
        
        let accountants = [
            Accountant(value: [generateId(), [generateId(), "Helen", "Accountant1"], 100, ["place A1", "12-13"], "type1"]),
            Accountant(value: [generateId(), [generateId(), "Mark", "Accountant2"], 100, ["place A2", "12-13"], "type2"]),
            Accountant(value: [generateId(), [generateId(), "Clark", "Accountant3"], 100, ["place A3", "12-13"], "type1"]),
            Accountant(value: [generateId(), [generateId(), "Brin", "Accountant4"], 100, ["place A4", "12-13"], "type2"]),
        ]
        
        try! realm.write {
            realm.add(managers)
            realm.add(workers)
            realm.add(accountants)
        }
    }
}

private func generateId() -> String {
    return UUID().uuidString
}
