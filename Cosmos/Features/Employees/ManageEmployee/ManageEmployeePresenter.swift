//
//  ManagerEmployeePresenter.swift
//  Cosmos
//
//  Created by Anton Selyanin on 16/10/2016.
//  Copyright © 2016 Anton Selyanin. All rights reserved.
//

import Foundation

protocol ManageEmployeePresenterProtocol: class {
    var employeeType: EmployeeType { get set }
    
    func tappedEdit()
    
    func tappedCancel()
    
    func tappedSave()
    
    func bind(view: ManageEmployeeViewProtocol)
}

class ManageEmployeePresenter: ManageEmployeePresenterProtocol {
    private let service: ManageEmployeeServiceProtocol
    private weak var view: ManageEmployeeViewProtocol?
    
    private var commonFields: [EmployeeFieldViewModel] = []
    private var typeFields: [EmployeeFieldViewModel] = []
    
    init(service: ManageEmployeeServiceProtocol) {
        self.service = service
        employeeType = service.employeeType
    }
    
    var employeeType: EmployeeType {
        didSet {
            typeFields = service.typeFields(of: employeeType)
            switchToEdit()
        }
    }
    
    func bind(view: ManageEmployeeViewProtocol) {
        self.view = view
        resetViewMode()
    }
    
    func tappedEdit() {
        switchToEdit()
    }
    
    func tappedCancel() {
        resetViewMode()
    }
    
    func tappedSave() {
        do {
            // TODO: this is hack
            view?.set(mode: .view, commonFields: commonFields, typeFields: typeFields)
            
            try service.save(type: employeeType, fields: commonFields + typeFields)
            resetViewMode()
        } catch {
            view?.show(error: "Couldn't not save changes")
        }
    }
    
    private func switchToEdit() {
        view?.set(mode: .edit, commonFields: commonFields, typeFields: typeFields)
    }
    
    private func resetViewMode() {
        employeeType = service.employeeType
        commonFields = service.commonFields()
        typeFields = service.typeFields(of: employeeType)
        view?.set(mode: .view, commonFields: commonFields, typeFields: typeFields)
    }
}
