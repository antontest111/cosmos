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

protocol EmployeesListViewProtocol: class {
//    func setEditMode(enabled: Bool)
    func reloadData()
}

class EmployeesListController: UIViewController, EmployeesListViewProtocol {
    private let tableManager: DynamicTableManager<EmployeeType, String, StringTableCell, EmployeesTableHeader>
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
    
    override func viewDidLoad() {
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        
        presenter.bind(view: self)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Edit", style: .plain, target: self, action: #selector(editMode))
    }
    
    func editMode() {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
        } else {
            tableView.setEditing(true, animated: true)
        }
    }
    
    func reloadData() {
        tableManager.reloadData()
    }
}

