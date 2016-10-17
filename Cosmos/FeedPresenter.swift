//
//  FeedPresenter.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import RxSwift

protocol FeedPresenterProtocol: class {
    func bind(view: FeedViewProtocol)
}

class FeedPresenter: FeedPresenterProtocol {
    private weak var view: FeedViewProtocol?
    private let service: FeedServiceProtocol = FeedService()
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    func bind(view: FeedViewProtocol) {
        self.view = view
        
        view.showProgress()
        
        service.fetchFeed(from: URL(string: "http://storage.space-o.ru/testXmlFeed.xml")!)
            .observeOn(MainScheduler.instance)
            //TODO: remove :D
//            .delay(5, scheduler: MainScheduler.instance)
            .do(onDispose: view.hideProgress)
            .subscribe(onNext: self.updateUI(with:))
            .addDisposableTo(disposeBag)
    }
    
    private func updateUI(with quotes: [Quote]) {
        view?.set(quotes: quotes)
    }
}
