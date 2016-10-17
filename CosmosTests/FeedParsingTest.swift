//
//  FeedParsingTest.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import XCTest
import Nimble
@testable import Cosmos

class FeedParsingTest: XCTestCase {
    func test() {
        let string =
            "<result>"
                + "<totalPages>355</totalPages>"
                + "<quotes>"
                    + "<quote>"
                        + "<id>424876</id>"
                        + "<date>10/10/2013, 13:12</date>"
                        + "<text>"
                        + "<![CDATA["
                        + "text1"
                        + "]]>"
                        + "</text>"
                    + "</quote>"
                    + "<quote>"
                        + "<id>424875</id>"
                        + "<date>10/10/2013, 12:46</date>"
                        + "<text>"
                        + "<![CDATA["
                        + "text2"
                        + "]]>"
                        + "</text>"
                    + "</quote>"
                + "</quotes>"
            + "</result>"
        
        let result = FeedParser.parse(data: string.data(using: .utf8)!)
        
        expect(result) == [
            Quote(id: "424876", date: "10/10/2013, 13:12", text: "text1"),
            Quote(id: "424875", date: "10/10/2013, 12:46", text: "text2")
        ]
    }
}
