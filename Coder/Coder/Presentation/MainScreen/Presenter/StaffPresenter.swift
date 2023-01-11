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
    func filterTableView(searchText: String?, sort: SortModel?)
}

class StaffPresenter: StaffViewPresenterProtocol {
    
    weak var view: StaffViewProtocol?
    let networkService: NetworkServiceProtocol
    var items: [Person]?
    var departments = [Department]()
    var staff: Staff?
    private lazy var staffModel = StaffModel()
    var selectedDepartmentPath: IndexPath? {
        didSet {
            filterTableView(searchText: nil, sort: nil)
        }
    }
    
    required init(view: StaffViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        initDepartments()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
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
                    self?.filterTableView(searchText: nil, sort: nil)
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
    
    func filterTableView(searchText: String?, sort: SortModel?) {
        staffModel.items = staff?.items
        staffModel.departments = departments
        staffModel.selectedDepartmentPath = self.selectedDepartmentPath
        staffModel.searchText = searchText?.lowercased() ?? ""
        staffModel.sortModel = sort
        self.items = staffModel.filteredData()
    }
}
