//
//  ManagerEmployeePresenter.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation

protocol ManageEmployeePresenterProtocol: class {
    var employeeType: EmployeeType { get }
    
    func tappedEdit()
    
    func tappedCancel()
    
    func tappedSave()
    
    func bind(view: ManageEmployeeViewProtocol)
}

class ManageEmployeePresenter: ManageEmployeePresenterProtocol {
    private let service: ManageEmployeeServiceProtocol
    private weak var view: ManageEmployeeViewProtocol?
    
    private var fields: [[EmployeeFieldViewModel]] = []
    
    init(service: ManageEmployeeServiceProtocol) {
        self.service = service
    }
    
    var employeeType: EmployeeType {
        return service.employeeType
    }
    
    func bind(view: ManageEmployeeViewProtocol) {
        self.view = view
        self.fields = service.fields()
        view.set(mode: .view, fields: fields)
    }
    
    func tappedEdit() {
        view?.set(mode: .edit, fields: fields)
    }
    
    func tappedCancel() {
        self.fields = service.fields()
        view?.set(mode: .view, fields: fields)
    }
    
    func tappedSave() {
        view?.set(mode: .view, fields: fields)
        service.save(fields: Array(fields.joined()))
    }
}
