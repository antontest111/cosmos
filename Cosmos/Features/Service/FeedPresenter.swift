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
    
    func requestReload()
}

class FeedPresenter: FeedPresenterProtocol {
    private weak var view: FeedViewProtocol?
    private let service: FeedServiceProtocol = FeedService()
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    func bind(view: FeedViewProtocol) {
        self.view = view
        
        requestReload()
    }
    
    func requestReload() {
        view?.set(quotes: [])
        view?.showProgress()

        service.fetchFeed(from: URL(string: "http://storage.space-o.ru/testXmlFeed.xml")!)
            .observeOn(MainScheduler.instance)
            // This is an artificial delay
            .delay(1, scheduler: MainScheduler.instance)
            .do(onDispose: self.onRequestStopped)
            .subscribe(onNext: self.updateUI(with:),
                       onError: self.showError)
            .addDisposableTo(disposeBag)
    }
    
    private func onRequestStopped() {
        view?.hideProgress()
    }
    
    private func updateUI(with quotes: [Quote]) {
        view?.set(quotes: quotes)
    }
    
    private func showError(_ error: Error) {
        view?.show(error: "Sorry, couldn't load feed.")
    }
}
