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

protocol ManageEmployeeViewProtocol: class {
    func set(mode: ManagingMode, fields: [[EmployeeFieldViewModel]])
}

class ManageEmployeeController: UIViewController {
    fileprivate let tableView: UITableView
    fileprivate let tableManager: TableManager
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
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.allowsSelection = false
        
        self.tableManager = TableManager(tableView: tableView)
        self.tableView = tableView
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        view.addSubview(tableView)
        
        tableView.register(cell: TextWithTitleCell.reusableType)
        tableView.register(cell: EditTextWithTitleCell.reusableType)
        tableView.register(nib: EmployeeTypeSelectorCell.self)
        tableView.autoPinEdgesToSuperviewEdges()
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
            print(">>> Selected type: \(newValue)")
//            employeeType = 
        }
    }
}

extension ManageEmployeeController: ManageEmployeeViewProtocol {
    func set(mode: ManagingMode, fields: [[EmployeeFieldViewModel]]) {
        var rows: [[Row]] = []
        switch mode {
        case .view:
            rows.append(contentsOf: fields.map(convertToViewRows))
        case .edit:
            rows.append([TableRow<EmployeeTypeSelectorDelegate, EmployeeTypeSelectorCell>(item: self)])
            rows.append(contentsOf: fields.map(convertToEditRows))
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
        return fields.map(ViewFieldRow.init(item:))
    }

    private func convertToEditRows(_ fields: [EmployeeFieldViewModel]) -> [Row] {
        return fields.map(EditFieldRow.init(item:))
    }
}
