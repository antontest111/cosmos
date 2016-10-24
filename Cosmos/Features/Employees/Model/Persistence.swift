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
        
        var index = -1
        let nextIndex = { () -> Int in index += 1; return index }
        
        let managers = [
            Manager(value: [generateId(), ["Jane", "Manager1"], 100, nextIndex(), "1-2"]),
            Manager(value: [generateId(), ["Harry", "Manager2"], 100, nextIndex(), "1-2"]),
            Manager(value: [generateId(), ["Olivia", "Manager3"], 100, nextIndex(), "1-2"]),
            Manager(value: [generateId(), ["Martin", "Manager4"], 100, nextIndex(), "1-2"])
        ]
        
        index = -1
        
        let workers = [
            Worker(value: [generateId(), ["Helen", "Worker1"], 100, nextIndex(), "place 1", "12-13"]),
            Worker(value: [generateId(), ["Justin", "Worker2"], 100, nextIndex(), "place 2", "12-13"]),
            Worker(value: [generateId(), ["Mario", "Worker3"], 100, nextIndex(), "place 3", "12-13"]),
            Worker(value: [generateId(), ["Olga", "Worker4"], 100, nextIndex(), "place 4", "12-13"]),
        ]
        
        index = -1
        
        let accountants = [
            Accountant(value: [generateId(), ["Helen", "Accountant1"], 100, nextIndex(), "place A1", "12-13", 0]),
            Accountant(value: [generateId(), ["Mark", "Accountant2"], 100, nextIndex(), "place A2", "12-13", 1]),
            Accountant(value: [generateId(), ["Clark", "Accountant3"], 100, nextIndex(), "place A3", "12-13", 0]),
            Accountant(value: [generateId(), ["Brin", "Accountant4"], 100, nextIndex(), "place A4", "12-13", 1]),
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
