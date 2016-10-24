//
//  ManageEmployeeController.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation
import UIKit

enum ManagingMode {
    case view
    case edit
}

private typealias ViewFieldRow = TableRow<EmployeeFieldViewModel, TextWithTitleCell>
private typealias EditFieldRow = TableRow<EmployeeFieldViewModel, EditTextWithTitleCell>
private typealias EmployeeSelectorRow = TableRow<EmployeeTypeSelectorDelegate, EmployeeTypeSelectorCell>
private typealias EmployeeTitleRow = TableRow<EmployeeType, EmployeeTitleCell>

protocol ManageEmployeeViewProtocol: class, ErrorDisplay {
    func set(mode: ManagingMode, commonFields: [EmployeeFieldViewModel], typeFields: [EmployeeFieldViewModel])
}

class ManageEmployeeController: UITableViewController {
    fileprivate lazy var tableManager: TableManager = TableManager(tableView: self.tableView)
    fileprivate let presenter: ManageEmployeePresenter
    
    fileprivate var doneButton: UIBarButtonItem {
        return UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(tappedSave))
    }
    
    fileprivate var editButton: UIBarButtonItem {
        return UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(tappedEdit))
    }
    
    fileprivate var cancelButton: UIBarButtonItem {
        return UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tappedCancel))
    }

    init(presenter: ManageEmployeePresenter) {
        self.presenter = presenter
        super.init(style: .grouped)
    }
    
    override func viewDidLoad() {
        tableView.allowsSelection = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.register(nib: EmployeeTitleCell.self)
        tableView.register(nib: TextWithTitleCell.self)
        tableView.register(nib: EditTextWithTitleCell.self)
        tableView.register(nib: EmployeeTypeSelectorCell.self)
        tableView.register(nib: AccountantTypeCell.self)
        tableView.register(nib: AccountantTypeSelectorCell.self)
        presenter.bind(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tappedEdit() {
        presenter.tappedEdit()
    }
    
    func tappedSave() {
        presenter.tappedSave()
    }
    
    func tappedCancel() {
        presenter.tappedCancel()
    }
}

extension ManageEmployeeController: EmployeeTypeSelectorDelegate {
    var employeeType: EmployeeType {
        get {
            return presenter.employeeType
        }
        set {
            presenter.employeeType = newValue
        }
    }
}

extension ManageEmployeeController: ManageEmployeeViewProtocol {
    func set(mode: ManagingMode, commonFields: [EmployeeFieldViewModel], typeFields: [EmployeeFieldViewModel]) {
        var rows: [[Row]] = []
        switch mode {
        case .view:
            rows.append([EmployeeTitleRow(item: employeeType)])
            rows.append(convertToViewRows(commonFields))
            rows.append(convertToViewRows(typeFields))
        case .edit:
            rows.append([EmployeeSelectorRow(item: self)])
            rows.append(convertToEditRows(commonFields))
            rows.append(convertToEditRows(typeFields))
        }
        
        tableManager.setSections(rows: rows)
        switchMode(mode)
    }
    
    private func switchMode(_ mode: ManagingMode) {
        switch mode {
        case .edit:
            navigationItem.rightBarButtonItem = doneButton
            navigationItem.leftBarButtonItem = cancelButton
            
        case .view:
            navigationItem.rightBarButtonItem = editButton
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    private func convertToViewRows(_ fields: [EmployeeFieldViewModel]) -> [Row] {
        return fields.map(createViewRow)
    }

    private func convertToEditRows(_ fields: [EmployeeFieldViewModel]) -> [Row] {
        return fields.map(createEditRow)
    }

    private func createViewRow(_ viewModel: EmployeeFieldViewModel) -> Row {
        switch viewModel.type {
        case .accountantType:
            return TableRow<Int, AccountantTypeCell>(item: viewModel.intValue)
            
        default:
            return ViewFieldRow(item: viewModel)
        }
    }

    private func createEditRow(_ viewModel: EmployeeFieldViewModel) -> Row {
        switch viewModel.type {
        case .accountantType:
            return TableRow<EmployeeFieldViewModel, AccountantTypeSelectorCell>(item: viewModel)
            
        default:
            return EditFieldRow(item: viewModel)
        }
    }
}
