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
    var items: [Person]? { get }
    var selectedDepartment: IndexPath? { get set }
    var departments: [String] { get }
}

class StaffPresenter: StaffViewPresenterProtocol {
    
    weak var view: StaffViewProtocol?
    let networkService: NetworkServiceProtocol
    var items: [Person]?
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
                    self?.items = staff?.items
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
}
