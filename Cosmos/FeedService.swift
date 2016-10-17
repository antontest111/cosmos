//
//  FeedService.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol FeedServiceProtocol: class {
    func fetchFeed(from url: URL) -> Observable<[Quote]>
}

class FeedService: FeedServiceProtocol {
    func fetchFeed(from url: URL) -> Observable<[Quote]> {
        return URLSession.shared.rx
            .data(URLRequest(url: url))
            .map(FeedParser.parse)
    }
}
