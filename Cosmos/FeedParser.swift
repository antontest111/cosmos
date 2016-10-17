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
    private var readData: (String) -> Void = { _ in }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        switchReader(for: elementName)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard elementName == Tags.quote else { return }
        
        result.append(currentQuote)
        currentQuote = Quote(id: "", date: "", text: "")
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        readData(string)
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        readData(String(data: CDATABlock, encoding: .utf8) ?? "")
    }
    
    private func switchReader(for elementName: String) {
        switch elementName {
        case Tags.id:
            readData = { self.currentQuote.id = $0 }
            
        case Tags.date:
            readData = { self.currentQuote.date = $0 }
            
        case Tags.text:
            readData = { self.currentQuote.text = $0 }
            
        default:
            readData = { _ in }
        }
    }
}
