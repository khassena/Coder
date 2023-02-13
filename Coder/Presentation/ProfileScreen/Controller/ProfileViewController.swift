//
//  ProfileViewController.swift
//  Coder
//
//  Created by Amanzhan Zharkynuly on 16.01.2023.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {
    
    var rootView: ProfileRootView {
        return self.view as! ProfileRootView
    }
    
    var presenter: ProfileViewPresenterProtocol?
    var navController: UINavigationController?
    
    override func loadView() {
        super.loadView()
        self.view = ProfileRootView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        rootView.setupView()
        setBackButton()
        setDelegates()
        presenter?.configureData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootView.avatarImage.applyshadowWithCorner(
            containerView: rootView.containerView,
            cornerRadious: Constants.ProfileView.cornerRadius
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.dateInfoStack.isFavorite = presenter?.checkIsFavorite() == true
    }
}

extension ProfileViewController {
    
    func setDelegates() {
        rootView.phoneInfoStack.delegate = self
        rootView.dateInfoStack.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setBackButton() {
        let backButton = BackBarItem(target: navController ?? UINavigationController())
        navigationItem.leftBarButtonItem = backButton
    }
}

extension ProfileViewController: ProfileViewProtocol {
    
    func dataReceived(item: Person, birthday: String, phone: String, age: String, isFavorite: Bool) {
        rootView.setData(
            firstName: item.firstName,
            lastName: item.lastName,
            tag: item.userTag.lowercased(),
            department: item.department.name,
            avatar: Constants.Staff.defaultImage,
            dateOfBirth: birthday,
            yearsOld: age,
            phoneNumber: phone,
            isFavorite: isFavorite
        )
    }
    
    func imageReceived(image: UIImage) {
        rootView.changeAvatar(image: image)
    }
}

extension ProfileViewController: PhoneViewDelegate {
    
    func didTapToCall(phoneNumber: String, _ stackView: PhoneView) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let number = UIAlertAction(title: phoneNumber, style: .default) { _ in
            if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
                let application: UIApplication = UIApplication.shared
                if application.canOpenURL(phoneCallURL) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancel.setValue(UIColor.black, forKey: "titleTextColor")
        number.setValue(UIColor.black, forKey: "titleTextColor")
        alert.addAction(number)
        alert.addAction(cancel)
        stackView.clickAnimation {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
extension ProfileViewController: DateOfBirthViewDelegate {
    
    func didTapToChange(star: UIImageView) {
        star.clickAnimation {
            
            if self.presenter?.checkIsFavorite() == true {
                star.image = Constants.ProfileView.starImage
                self.presenter?.deleteFromRealm()
            } else {
                star.image = Constants.ProfileView.filledStar
                self.presenter?.addToRealm()
            }
        }
    }
    
}

extension ProfileViewController: UIGestureRecognizerDelegate { }
