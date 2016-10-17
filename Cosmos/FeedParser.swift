//
//  FeedParser.swift
//  Cosmos
//
//  Created by Anton Selyanin on 17/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation

class FeedParser {
    class func parse(data: Data) -> [Quote] {
        let delegate = QuoteParserDelegate()
        let parser = XMLParser(data: data)
        parser.delegate = delegate
        parser.parse()
        return delegate.result
    }
}

class QuoteParserDelegate: NSObject, XMLParserDelegate {
    private enum Tags {
        static let quote = "quote"
        static let id = "id"
        static let date = "date"
        static let text = "text"
    }
    
    private(set) var result: [Quote] = []
    
    private var currentQuote: Quote = Quote(id: "", date: "", text: "")
    private var textBuffer: String = ""
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        let text = textBuffer.trimmingCharacters(in: .whitespacesAndNewlines)
        textBuffer = ""
        
        switch elementName {
        case Tags.id:
            currentQuote.id = text
            
        case Tags.date:
            currentQuote.date = text
            
        case Tags.text:
            currentQuote.text = text

        case Tags.quote:
            result.append(currentQuote)
            currentQuote = Quote(id: "", date: "", text: "")
            
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        textBuffer.append(string)
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        let string = String(data: CDATABlock, encoding: .utf8) ?? ""
        textBuffer.append(string)
    }
}
