//
//  MainPresenter.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 01.12.2022.
//

import Foundation
import UIKit
import RealmSwift

protocol StaffViewProtocol: AnyObject {
    func networkSuccess()
    func imageLoader(with image: UIImage, indexPath: IndexPath)
    func networkFailure(error: Error)
    func showBirthdaySelected(_ show: Bool)
}

protocol StaffViewPresenterProtocol {
    init(view: StaffViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    
    var staff: Staff? { get }
    var items: [Person]? { get set }
    var selectedDepartmentPath: IndexPath? { get set }
    var departments: [Department] { get }
    var showBirthday: Bool { get set }
    var itemsForSection: [Person]? { get }
    var sortModel: SortModel? { get }
    func getData()
    func getImage(with url: URL, indexPath: IndexPath)
    func deleteItemFromDB(item: Person)
    func routToSortScreen(view: SortViewProtocol, staff: Staff?)
    func routToProfileScreen(item: Person?)
    func filterTableView(searchText: String?, sort: SortModel?)
}

class StaffPresenter: StaffViewPresenterProtocol {
    
    let realm = try! Realm()
    
    weak var view: StaffViewProtocol?
    let networkService: NetworkServiceProtocol
    var items: [Person]?
    var itemsForSection: [Person]?
    var departments = [Department]()
    var staff: Staff?
    var router: RouterProtocol?
    var sortModel: SortModel?
    lazy var showBirthday: Bool = false
    var selectedDepartmentPath: IndexPath? {
        didSet {
            filterTableView(searchText: nil, sort: self.sortModel)
        }
    }
    
    required init(view: StaffViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
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
                    self?.filterTableView(searchText: nil, sort: self?.sortModel)
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
        self.itemsForSection = nil
        var staffModel = StaffModel()
        staffModel.items = staff?.items
        staffModel.departments = departments
        staffModel.selectedDepartmentPath = self.selectedDepartmentPath
        staffModel.searchText = searchText?.lowercased() ?? ""
        staffModel.sortModel = sort
        self.items = staffModel.filteredData()
        self.itemsForSection = staffModel.filteredSecondSection
        showBirthday = staffModel.showBirthday
        view?.showBirthdaySelected(showBirthday)
        self.sortModel = sort
    }
    
    func deleteItemFromDB(item: Person) {
        let deleteObject = realm.objects(FavoritePerson.self).filter{item.id == $0.id}
        
        do{
            try realm.write({
                realm.delete(deleteObject)
            })
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    func routToSortScreen(view: SortViewProtocol, staff: Staff?) {
        router?.showSortScreen(view: view, staff: staff)
    }
    
    func routToProfileScreen(item: Person?) {
        router?.showProfileScreen(item: item, target: .staff)
    }
}
