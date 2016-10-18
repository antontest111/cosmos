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

class GalleryViewController: UIViewController, UIScrollViewDelegate {
    private let pageCount = 16
    private var currentIndex: Int = 0
    
    private var prevPage: ContainerController?
    private var currentPage: ContainerController?
    private var nextPage: ContainerController?
    
    let scrollView: UIScrollView = with(UIScrollView()) {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isDirectionalLockEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.autoPinEdgesToSuperviewEdges()
        scrollView.delegate = self
        
        view.layoutIfNeeded()
        
        scrollView.contentSize = CGSize(
            width: CGFloat(pageCount) * scrollView.frame.width,
            height: scrollView.frame.height)
        
        currentPage = loadPage(index: 0)
        nextPage = loadPage(index: 1)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let index = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)

        switchPage(index: index)
    }
    
    private func switchPage(index: Int) {
        guard (0..<pageCount).contains(index)  else { return }
        
        if index > currentIndex {
            prevPage?.removeFromParentViewController()
            prevPage?.didMove(toParentViewController: nil)
            
            prevPage = currentPage
            currentPage = nextPage
            nextPage = loadPage(index: index + 1)
        } else {
            nextPage?.removeFromParentViewController()
            nextPage?.didMove(toParentViewController: nil)
            
            nextPage = currentPage
            currentPage = prevPage
            prevPage = loadPage(index: index - 1)
        }
    }
    
    private func loadPage(index: Int) -> ContainerController? {
        guard (0..<pageCount).contains(index) else { return nil }
        
        let size = scrollView.frame.size
        let origin = CGPoint(x: CGFloat(index) * size.width, y: 0)
        let frame = CGRect(origin: origin, size: size)
        
        let page = ContainerController(image: UIImage(named: "image\(index).jpg"))
        
        page.view.frame = frame
        
        addChildViewController(page)
        scrollView.addSubview(page.view)
        page.didMove(toParentViewController: self)
        
        return page
    }
}

class ContainerController: UIViewController {
    private let imageView: UIImageView
    
    init(image: UIImage?) {
        imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        imageView.autoPinEdgesToSuperviewEdges()
    }
}
