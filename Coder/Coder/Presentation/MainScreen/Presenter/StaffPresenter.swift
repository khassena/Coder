//
//  MainPresenter.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 01.12.2022.
//

import Foundation

protocol StaffViewProtocol: AnyObject {
    func networkSuccess()
    func networkFailure(error: Error)
}

protocol StaffViewPresenterProtocol {
    init(view: StaffViewProtocol, networkService: NetworkServiceProtocol)
    func getData()
    var staff: Staff? { get set }
    var selectedDepartment: IndexPath? { get set }
    var departments: [String] { get }
}

class StaffPresenter: StaffViewPresenterProtocol {
    weak var view: StaffViewProtocol?
    let networkService: NetworkServiceProtocol
    var staff: Staff?
    var selectedDepartment: IndexPath?
    var departments = [String]()
    
    required init(view: StaffViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        initDepartments()
        getData()
    }
    
    func initDepartments() {
        Department.allCases.forEach { department in
            self.departments.append(department.name)
        }
    }
    
    func getData() {
        networkService.fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let staff):
                    self?.staff = staff
                    self?.view?.networkSuccess()
                case .failure(let error):
                    self?.view?.networkFailure(error: error)
                }
            }
        }
    }
}
