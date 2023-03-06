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
    var realm: Realm? { get set }
    var view: StaffViewProtocol? { get set }
    var staff: Staff? { get set }
    var items: [Person]? { get set }
    var selectedDepartmentPath: IndexPath? { get set }
    var departments: [Department] { get }
    var itemsForSection: [Person]? { get }
    var sortModel: SortModel? { get }
    func getData()
    func getImage(with url: URL, indexPath: IndexPath)
    func addToRealm(item: Person)
    func deleteItemFromRealm(item: Person)
    func checkIsFavorite(item: Person) -> Bool
    func routToSortScreen(view: SortViewProtocol, staff: Staff?)
    func routToProfileScreen(item: Person?)
    func filterTableView(searchText: String?, sort: SortModel?)
}

class StaffPresenter: StaffViewPresenterProtocol {
    
    var realm: Realm?
    
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
        itemsForSection = nil
        var staffModel = StaffModel()
        staffModel.items = staff?.items
        staffModel.departments = departments
        staffModel.selectedDepartmentPath = selectedDepartmentPath
        staffModel.searchText = searchText?.lowercased() ?? ""
        staffModel.sortModel = sort
        items = staffModel.filteredData()
        itemsForSection = staffModel.filteredSecondSection
        view?.showBirthdaySelected(staffModel.showBirthday)
        sortModel = sort
    }
    
    func addToRealm(item: Person) {
        guard let realm = realm else { return }
        
        let data = FavoritePerson()
        data.id = item.id
        data.avatarUrl = item.avatarUrl
        data.firstName = item.firstName
        data.lastName = item.lastName
        data.department = item.department.name
        data.position = item.position
        data.userTag = item.userTag.lowercased()
        data.birthday = item.birthday
        data.phone = item.phone
        
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print(error)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataBaseUpdated") , object: nil)
    }
    
    func deleteItemFromRealm(item: Person) {
        guard let realm = realm else { return }
        
        let deleteObject = realm.objects(FavoritePerson.self).filter{item.id == $0.id}
        
        do{
            try realm.write({
                realm.delete(deleteObject)
            })
        }catch let error {
            print(error.localizedDescription)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataBaseUpdated") , object: nil)
    }
    
    func checkIsFavorite(item: Person) -> Bool {
        return realm?.objects(FavoritePerson.self).filter { item.id == $0.id }.first != nil
    }
    
    func routToSortScreen(view: SortViewProtocol, staff: Staff?) {
        router?.showSortScreen(view: view, staff: staff)
    }
    
    func routToProfileScreen(item: Person?) {
        router?.showProfileScreen(item: item, target: .staff)
    }
}
