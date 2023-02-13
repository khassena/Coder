//
//  ProfilePresenter.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 16.01.2023.
//

import Foundation
import UIKit
import RealmSwift

protocol ProfileViewProtocol: AnyObject {
    func dataReceived(item: Person, birthday: String, phone: String, age: String, isFavorite: Bool)
    func imageReceived(image: UIImage)
}

protocol ProfileViewPresenterProtocol {
    var item: Person? { get set }
    init(view: ProfileViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    var router: RouterProtocol? { get set }
    func configureData()
    func addToRealm()
    func deleteFromRealm()
    func checkIsFavorite() -> Bool
}

class ProfilePresenter: ProfileViewPresenterProtocol {
    
    let realm = try! Realm()
    
    var item: Person?
    var profileModel = ProfileModel()
    weak var view: ProfileViewProtocol?
    var networkService: NetworkServiceProtocol
    var router: RouterProtocol?
    required init(view: ProfileViewProtocol,
                  networkService: NetworkServiceProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func configureData() {
        guard let item = item,
              let avatarUrl = URL(string: item.avatarUrl) else { return }
        
        let birthdayDate = profileModel.getFormatted(date: item.birthdayDate)
        let phoneNumber = profileModel.getFormatted(phone: item.phone)
        let age = profileModel.getFormatted(age: item.birthdayDate)
        getImage(of: avatarUrl)
        
        view?.dataReceived(item: item,
                          birthday: birthdayDate,
                          phone: phoneNumber,
                          age: age,
                          isFavorite: self.checkIsFavorite())
    }
    
    func getImage(of url: URL) {
        networkService.fetchImage(with: url) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.view?.imageReceived(image: image)
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func checkIsFavorite() -> Bool {
        guard let item = item else { return false }
        return realm.objects(FavoritePerson.self).filter { item.id == $0.id }.first != nil
    }
    
    func addToRealm() {
        guard let item = item else { return }
        
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
    
    func deleteFromRealm() {
        guard let item = item else { return }
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
    
}
