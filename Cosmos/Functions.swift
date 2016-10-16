//
//  Functions.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation

func with<T>(_ object: T, _ initializer: (T) -> Void) -> T {
    initializer(object)
    return object
}
