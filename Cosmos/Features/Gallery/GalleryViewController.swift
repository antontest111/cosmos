//
//  GalleryViewController.swift
//  Cosmos
//
//  Created by Anton Selyanin on 17/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

protocol GalleryViewProtocol: class {
    func setNextButton(enabled: Bool)
    
    func setPrevButton(enabled: Bool)
    
    func preparePage(index: Int)
    
    func scrollTo(index: Int)
}

class GalleryViewController: UIViewController, UIScrollViewDelegate {
    fileprivate var prevPage = ContainerController(image: nil)
    fileprivate var currentPage = ContainerController(image: nil)
    fileprivate var nextPage = ContainerController(image: nil)
    
    fileprivate var presenter: GalleryPresenterProtocol
    
    fileprivate let scrollView: UIScrollView = with(UIScrollView()) {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isDirectionalLockEnabled = true
    }
    
    init(presenter: GalleryPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage.image(ofColor: UIColor(white: 1, alpha: 0.5))
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.barStyle = .default
        
        view.addSubview(scrollView)
        scrollView.autoPinEdgesToSuperviewEdges()
        scrollView.delegate = self
        
        view.layoutIfNeeded()
        
        scrollView.contentSize = CGSize(
            width: CGFloat(presenter.pagesCount) * scrollView.frame.width,
            height: scrollView.frame.height)
        
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(title: "Prev", style: .plain, target: self, action: #selector(tappedPrev))
        
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(tappedNext))
        
        presenter.bind(view: self)
    }
    
    func tappedPrev() {
        presenter.tappedPrevious()
    }
    
    func tappedNext() {
        presenter.tappedNext()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let index = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth)) + 1
        
        presenter.switchedIndex(to: index)
    }
    
    fileprivate func load(page: ContainerController, index: Int) {
        guard (0..<presenter.pagesCount).contains(index) else { return }
        
        let size = scrollView.bounds.size
        let origin = CGPoint(x: CGFloat(index) * size.width, y: 0)
        let frame = CGRect(origin: origin, size: size)
        
        page.set(image: presenter.image(at: index))
        
        page.view.frame = frame
        
        guard page.view.superview == nil else { return }
        
        addChildViewController(page)
        scrollView.addSubview(page.view)
        page.didMove(toParentViewController: self)
        
    }
}

extension GalleryViewController: GalleryViewProtocol {
    func setNextButton(enabled: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = enabled
    }
    
    func setPrevButton(enabled: Bool) {
        navigationItem.leftBarButtonItem?.isEnabled = enabled
    }

    func scrollTo(index: Int) {
        let pageWidth = scrollView.bounds.width
        let pageHeight = scrollView.bounds.height
        
        let rect = CGRect(x: pageWidth * CGFloat(index), y: 0, width: pageWidth, height: pageHeight)
        
        scrollView.scrollRectToVisible(rect, animated: true)
    }
    
    func preparePage(index: Int) {
        load(page: prevPage, index: index - 1)
        load(page: currentPage, index: index)
        load(page: nextPage, index: index + 1)
    }
}
