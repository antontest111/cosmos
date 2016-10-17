//
//  FeedService.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import RxSwift

protocol FeedServiceProtocol: class {
    func rx_fetchFeed() -> Observable<[Quote]>
}

//class FeedService: FeedServiceProtocol {
//    func rx_fetchFeed() -> Observable<[Quote]> {
//        return URLSession.shared.rx.data()
//    }
//}
