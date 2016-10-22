//
//  GalleryPresenter.swift
//  Cosmos
//
//  Created by Anton Selyanin on 22/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

protocol GalleryPresenterProtocol: class {
    var pagesCount: Int { get }
    
    func bind(view: GalleryViewProtocol)
    
    func tappedNext()
    
    func tappedPrevious()
    
    func switchedIndex(to: Int)
    
    func image(at: Int) -> UIImage?
}

class GalleryPresenter: GalleryPresenterProtocol {
    let pagesCount: Int = 16
    
    private var currentIndex: Int = 0
    private weak var view: GalleryViewProtocol?
    
    func bind(view: GalleryViewProtocol) {
        self.view = view
        
        view.preparePage(index: currentIndex)
        resetNavigationButtons()
    }
    
    func tappedNext() {
        guard currentIndex < pagesCount else { return }
        
        switchedIndex(to: currentIndex + 1)
        view?.scrollTo(index: currentIndex)
    }
    
    func tappedPrevious() {
        guard currentIndex > 0 else { return }
        
        switchedIndex(to: currentIndex - 1)
        view?.scrollTo(index: currentIndex)
    }
    
    func switchedIndex(to index: Int) {
        guard currentIndex != index, (0..<pagesCount).contains(index) else { return }
        
        view?.preparePage(index: index)
        currentIndex = index
        resetNavigationButtons()
    }
    
    func image(at index: Int) -> UIImage? {
        return UIImage(named: "image\(index).jpg")
    }
    
    private func resetNavigationButtons() {
        view?.setNextButton(enabled: currentIndex < pagesCount - 1)
        view?.setPrevButton(enabled: currentIndex > 0)
    }
}
