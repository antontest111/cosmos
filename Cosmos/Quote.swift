//
//  Quote.swift
//  Cosmos
//
//  Created by Anton Selyanin on 17/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation

struct Quote {
    var id: String
    var date: String
    var text: String
}

extension Quote: Equatable {}
func ==(lhs: Quote, rhs: Quote) -> Bool {
    return lhs.id == rhs.id
        && lhs.date == rhs.date
        && lhs.text == rhs.text
}
