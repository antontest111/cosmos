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
        
        // Check if base is empty
        guard realm.objects(Person.self).isEmpty else { return  }
        
        let firstNames = ["Jane", "Olivia", "Ron", "Harry", "Hellen", "Jack"]
        let secondNames = ["Smith", "Kane", "Kumar", "Oliver", "Clark", "Stone"]
        
        // Generate names
        var names: [(String, String)] = firstNames.reduce([]) { state, next in
            return state + secondNames.map({ (next, $0) })
        }
        
        // Get random name
        let nextName: () -> (String, String) = {
            return names.remove(at: Int(arc4random()) % names.count)
        }
        
        var index = -1
        let nextIndex = { () -> Int in index += 1; return index }

        // Generate managers, sorted by name :)
        let managers = times(4, producer: nextName)
            .sorted(by: <)
            .map {
                Manager(value: [generateId(), [$0, $1], 100, nextIndex(), "1-2"])
            }

        index = -1

        // Generate workers, sorted by name :)
        let workers = times(4, producer: nextName)
            .sorted(by: <)
            .map {
                Worker(value: [generateId(), [$0, $1], 100, nextIndex(), "place \(index)", "12-13"])
            }

        index = -1

        // Generate accountants, sorted by name :)
        let accountants = times(4, producer: nextName)
            .sorted(by: <)
            .map {
                Accountant(value: [generateId(), [$0, $1], 100, nextIndex(), "place A\(index)", "12-13", Int(arc4random() % 2)])
            }
        
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


private func times<T>(_ n: Int, producer: () -> T) -> [T] {
    var result = [T]()
    for _ in 0..<n {
        result.append(producer())
    }
    
    return result
}

private func <(lhs: (String, String), rhs: (String, String)) -> Bool {
    return "\(lhs.1) \(lhs.0)" < "\(rhs.1) \(rhs.0)"
}
