//
//  EmpoyeesListController.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

protocol EmployeesListViewProtocol: class, ErrorDisplay {
    func reloadData()
}

class EmployeesListController: UIViewController, EmployeesListViewProtocol {
    private let tableManager: DynamicTableManager<EmployeeType, EmployeeInfo, EmployeeListCell, EmployeesTableHeader>
    private let tableView: UITableView
    
    private let presenter: EmployeesListPresenterProtocol
    
    init(presenter: EmployeesListPresenterProtocol) {
        self.presenter = presenter
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableManager = DynamicTableManager(tableView: tableView, dataSource: presenter.dataSource)
        self.tableView = tableView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var editButton: UIBarButtonItem? {
        return navigationItem.leftBarButtonItem
    }
    
    override func viewDidLoad() {
        tableView.register(nib: EmployeeListCell.self)
        tableView.register(header: EmployeesTableHeader.self)
        tableView.rowHeight = 60

        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        
        presenter.bind(view: self)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(tappedAddEmployee))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
    }
    
    func toggleEditMode() {
        if tableView.isEditing {
            editButton?.title = "Edit"
            tableView.setEditing(false, animated: true)
        } else {
            editButton?.title = "Done"
            tableView.setEditing(true, animated: true)
        }
    }
    
    func tappedAddEmployee() {
        presenter.tappedAddNewEmployee()
    }
    
    func reloadData() {
        tableManager.reloadData()
    }
}

