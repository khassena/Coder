//
//  ProfilePresenter.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 16.01.2023.
//

import Foundation
import UIKit

protocol ProfileViewProtocol: AnyObject {
    func dataReceived(item: Person, birthday: String, phone: String, age: String)
    func imageReceived(image: UIImage)
}

protocol ProfileViewPresenterProtocol {
    var item: Person? { get set }
    init(view: ProfileViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    var router: RouterProtocol? { get set }
    func configureData()
    func routPopToRootView()
}

class ProfilePresenter: ProfileViewPresenterProtocol {
    
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
                          age: age)
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
    
    @objc func routPopToRootView() {
        router?.popToRootVC()
    }
    
}
