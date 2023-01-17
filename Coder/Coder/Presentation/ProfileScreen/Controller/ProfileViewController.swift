//
//  ProfileViewController.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 16.01.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var rootView: ProfileRootView {
        return self.view as! ProfileRootView
    }
    
    var presenter: ProfileViewPresenterProtocol?
    
    override func loadView() {
        super.loadView()
        self.view = ProfileRootView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        rootView.setupView()
        setBackButton()
        presenter?.configureData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootView.avatarImage.applyshadowWithCorner(
            containerView: rootView.containerView,
            cornerRadious: Constants.ProfileView.cornerRadius
        )
    }
    
    func setBackButton() {
        navigationItem.leftBarButtonItem = BackBarItem(target: navigationController ?? UINavigationController())
    }
}

extension ProfileViewController: ProfileViewProtocol {
    
    func dataReceived(item: Person, birthday: String, phone: String, age: String) {
        rootView.setData(
            firstName: item.firstName,
            lastName: item.lastName,
            tag: item.userTag.lowercased(),
            department: item.department.name,
            avatar: Constants.Staff.defaultImage,
            dateOfBirth: birthday,
            yearsOld: age,
            phoneNumber: phone
        )
    }
    
    func imageReceived(image: UIImage) {
        rootView.changeAvatar(image: image)
    }
}
