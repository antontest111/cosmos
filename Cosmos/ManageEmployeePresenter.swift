//
//  ManagerEmployeePresenter.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation

enum EmployeeFieldType {
    case firstName
    case lastName
    case salary
    case role
}

class EmployeeFieldViewModel {
    let type: EmployeeFieldType
    var value: String
    
    init(type: EmployeeFieldType, value: String) {
        self.type = type
        self.value = value
    }
}

protocol ManageEmployeePresenterProtocol: class {
    func tappedEdit()
    
    func tappedCancel()
    
    func tappedSave()
    
    func bind(view: ManageEmployeeViewProtocol)
}

class ManageEmployeePresenter: ManageEmployeePresenterProtocol {
    private let service: ManageEmployeeService
    private var employee: Employee
    private weak var view: ManageEmployeeViewProtocol?
    
    private var fields: [EmployeeFieldViewModel] = []
    
    init(employee: Employee, service: ManageEmployeeService) {
        self.employee = employee
        self.service = service
    }
    
    func bind(view: ManageEmployeeViewProtocol) {
        self.view = view
        self.fields = createFields(from: employee)
        view.set(mode: .view, fields: fields)
    }
    
    func tappedEdit() {
        view?.set(mode: .edit, fields: fields)
    }
    
    func tappedCancel() {
        self.fields = createFields(from: employee)
        view?.set(mode: .view, fields: fields)
    }
    
    func tappedSave() {
        view?.set(mode: .view, fields: fields)
    }
    
    private func createFields(from employee: Employee) -> [EmployeeFieldViewModel] {
        return [
            EmployeeFieldViewModel(type: .firstName, value: employee.personID.firstName),
            EmployeeFieldViewModel(type: .lastName, value: employee.personID.lastName),
            EmployeeFieldViewModel(type: .salary, value: String(describing: employee.salary))
        ]
    }
    
    private func modifyEmployee() {
        for field in fields {
            switch field.type {
            case .firstName:
                employee.personID.firstName = field.value
                
            case .lastName:
                employee.personID.firstName = field.value
            
            default:
                break
            }
        }
        
        service.save(employee: employee)
    }
}
