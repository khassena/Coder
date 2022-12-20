//
//  MainPresenter.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 01.12.2022.
//

import Foundation
import UIKit

protocol StaffViewProtocol: AnyObject {
    func networkSuccess()
    func imageLoader(with image: UIImage, indexPath: IndexPath)
    func networkFailure(error: Error)
}

protocol StaffViewPresenterProtocol {
    init(view: StaffViewProtocol, networkService: NetworkServiceProtocol)
    func getData()
    func getImage(with url: URL, indexPath: IndexPath)
    var staff: Staff? { get }
    var items: [Person]? { get set }
    var selectedDepartmentPath: IndexPath? { get set }
    var departments: [Department] { get }
}

class StaffPresenter: StaffViewPresenterProtocol {
    
    weak var view: StaffViewProtocol?
    let networkService: NetworkServiceProtocol
    var items: [Person]?
    var departments = [Department]()
    var staff: Staff?
    var selectedDepartmentPath: IndexPath? {
        didSet {
            filterTableView()
        }
    }
    
    required init(view: StaffViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        initDepartments()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getData()
        }
    }
    
    func initDepartments() {
        Department.allCases.forEach { department in
            self.departments.append(department)
        }
    }
    
    func getData() {
        networkService.fetchData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let staff):
                    self?.staff = staff
                    self?.filterTableView()
                    self?.view?.networkSuccess()
                case .failure(let error):
                    self?.view?.networkFailure(error: error)
                }
            }
        }
    }
    
    func getImage(with url: URL, indexPath: IndexPath) {
        networkService.fetchImage(with: url) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.view?.imageLoader(with: image, indexPath: indexPath)
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func filterTableView() {
        guard let selected = selectedDepartmentPath, departments[selected.row].name != Constants.Department.selectedDefault  else {
            self.items = staff?.items
            return
        }
        
        self.items = staff?.items.filter({ person in
            person.department == departments[selected.row]
        }) as? [Person]
    }
}
