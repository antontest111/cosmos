//
//  FeedViewController.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit


protocol FeedViewProtocol: class {
    func showProgress()
    
    func hideProgress()
    
    func set(quotes: [Quote])
}

class FeedViewController: UIViewController {
    private let tableView: UITableView
    fileprivate let tableManager: TableManager
    private let presenter: FeedPresenterProtocol
    
    fileprivate let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    init(presenter: FeedPresenterProtocol) {
        let tableView = UITableView()
        self.tableManager = TableManager(tableView: tableView)
        self.tableView = tableView
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        
        tableView.register(nib: QuoteTableCell.reusableType)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.allowsSelection = false
        
        view.addSubview(activityIndicator)
        activityIndicator.autoCenterInSuperview()
        
        presenter.bind(view: self)
    }
}

extension FeedViewController: FeedViewProtocol {
    func showProgress() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func hideProgress() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func set(quotes: [Quote]) {
        let rows = quotes.map(TableRow<Quote, QuoteTableCell>.init(item:))
        tableManager.setSection(rows: rows)
    }
}
